package org.alfresco.datasetservice.service;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Addresses an element inside a dataset document by a dot-notation field path,
 * e.g. {@code people.0.name} (object fields and numeric array indexes, {@code -} appends).
 * Provides get/set/append/remove, with "mkdir -p" style creation of intermediate objects
 * on set. An empty path refers to the document root. Field names containing a literal
 * {@code .} are not addressable (accepted trade-off).
 */
final class FieldPath {

    private FieldPath() {}

    static List<String> parse(String fieldPath) {
        List<String> tokens = new ArrayList<>();
        if (fieldPath == null) return tokens;
        String p = fieldPath.trim();
        if (p.isEmpty()) return tokens;
        // tolerate a leading dot
        if (p.startsWith(".")) p = p.substring(1);
        for (String seg : p.split("\\.", -1)) {
            if (!seg.isEmpty()) tokens.add(seg);
        }
        return tokens;
    }

    /** Returns the value at the field path, throwing IllegalArgumentException if any segment is missing. */
    static Object get(JSONObject root, String fieldPath) {
        Object current = root;
        for (String token : parse(fieldPath)) {
            current = step(current, token);
            if (current == null) {
                throw new IllegalArgumentException("No value at field path segment: " + token);
            }
        }
        return current;
    }

    /** Sets/replaces the value at the field path, creating intermediate objects as needed. */
    static void set(JSONObject root, String fieldPath, Object value) {
        List<String> tokens = parse(fieldPath);
        if (tokens.isEmpty()) {
            throw new IllegalArgumentException("Cannot set the document root; use a whole-document update");
        }
        Object parent = root;
        for (int i = 0; i < tokens.size() - 1; i++) {
            String token = tokens.get(i);
            Object next = step(parent, token);
            if (next == null) {
                if (parent instanceof JSONObject) {
                    JSONObject child = new JSONObject();
                    ((JSONObject) parent).put(token, child);
                    next = child;
                } else {
                    throw new IllegalArgumentException("Cannot create an intermediate node under an array at: " + token);
                }
            }
            parent = next;
        }
        putLeaf(parent, tokens.get(tokens.size() - 1), value);
    }

    /** Appends a value to the array located at the field path. */
    static void append(JSONObject root, String fieldPath, Object value) {
        Object target = get(root, fieldPath);
        if (!(target instanceof JSONArray)) {
            throw new IllegalArgumentException("Target at field path is not an array");
        }
        ((JSONArray) target).put(value);
    }

    /** Removes the member at the field path, throwing IllegalArgumentException if it does not exist. */
    static void remove(JSONObject root, String fieldPath) {
        List<String> tokens = parse(fieldPath);
        if (tokens.isEmpty()) {
            throw new IllegalArgumentException("Cannot remove the document root");
        }
        Object parent = root;
        for (int i = 0; i < tokens.size() - 1; i++) {
            parent = step(parent, tokens.get(i));
            if (parent == null) {
                throw new IllegalArgumentException("No value at field path");
            }
        }
        String last = tokens.get(tokens.size() - 1);
        if (parent instanceof JSONObject) {
            if (((JSONObject) parent).remove(last) == null) {
                throw new IllegalArgumentException("No such field: " + last);
            }
        } else if (parent instanceof JSONArray) {
            JSONArray a = (JSONArray) parent;
            int idx = parseIndex(last, a.length(), false);
            if (idx < 0 || idx >= a.length()) {
                throw new IllegalArgumentException("Array index out of range: " + last);
            }
            a.remove(idx);
        } else {
            throw new IllegalArgumentException("Parent at field path is not a container");
        }
    }

    private static Object step(Object current, String token) {
        if (current instanceof JSONObject) {
            JSONObject o = (JSONObject) current;
            return o.has(token) ? o.get(token) : null;
        } else if (current instanceof JSONArray) {
            JSONArray a = (JSONArray) current;
            int idx = parseIndex(token, a.length(), false);
            return (idx >= 0 && idx < a.length()) ? a.get(idx) : null;
        }
        return null;
    }

    private static void putLeaf(Object parent, String token, Object value) {
        if (parent instanceof JSONObject) {
            ((JSONObject) parent).put(token, value);
        } else if (parent instanceof JSONArray) {
            JSONArray a = (JSONArray) parent;
            if ("-".equals(token)) {
                a.put(value);
            } else {
                a.put(parseIndex(token, a.length(), true), value);
            }
        } else {
            throw new IllegalArgumentException("Parent at field path is not a container");
        }
    }

    private static int parseIndex(String token, int length, boolean allowEnd) {
        if ("-".equals(token)) return allowEnd ? length : -1;
        try {
            return Integer.parseInt(token);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Invalid array index: " + token);
        }
    }
}

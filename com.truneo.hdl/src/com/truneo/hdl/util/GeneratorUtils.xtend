package com.truneo.hdl.util

import java.util.List
import java.util.Arrays

class GeneratorUtils {

    static val List<String> letters = Arrays.asList("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K",
                                         "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",
                                         "W", "X", "Y", "Z"
    );
    
    static def String dbName(String name) {
        if (name.isNullOrEmpty) {
            return name
        }
        var dbName = name
        letters.forEach[letter|
        ]
        for (String letter : letters) {
            dbName = dbName.replaceAll(letter, "_" + letter.toLowerCase)
        }
        dbName = dbName.replaceFirst("^_", "")
        return dbName
    } 
}
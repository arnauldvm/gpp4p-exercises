package com.kodewerk.profile;

import java.util.*;
import java.io.*;

public class CheckIntegerTestHarness {
    public static void main(String[] args) throws IOException {
        testDataset("dataset1.dat");
        testDataset("dataset2.dat");
        testDataset("dataset3.dat");
    }

    public static void testDataset(String dataset) throws IOException {
        DataInputStream rdr = new DataInputStream(new FileInputStream(dataset));
        String s;
        List<String> allData = new ArrayList<>();
        try {
            while ((s = rdr.readUTF()) != null) {
                allData.add(s);
            }
        } catch (EOFException e) {
        }
        rdr.close();
        long starttime = System.currentTimeMillis();
        int truecount = 0;
        for (String data: allData) {
            if (checkInteger(data))
                truecount++;
        }
        System.out.println(truecount + " (count); time " + (System.currentTimeMillis() - starttime));
    }

    public static boolean checkInteger(String testInteger) {
        try {
            Integer theInteger = new Integer(testInteger);//fails if not  a number
            return
                    (theInteger.toString() != "") && //not empty
                    (theInteger.intValue() > 10) && //greater than ten
                    ((theInteger.intValue() >= 2) &&
                    (theInteger.intValue() <= 100000)) && //2>=X<=100000
                    (theInteger.toString().charAt(0) == '3'); //first digit is 3
        } catch (NumberFormatException err) {
            return false;
        }
    }

}

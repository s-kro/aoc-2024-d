#!/usr/bin/rdmd

/+ Advent of Code 2024 Day 5 Part 2 +/

import std.stdio;
import std.conv;
import std.algorithm;
import std.array;
import std.regex;

void main() {

  int iou = 0; // incorrectly ordered updates score 

  int i = 0;               // index
  char[] sep = ['|', ',']; // 'record' separators
  string[][][2] d;         // data    // (no conversion to integers,
  auto f = File("aoc_2024-5.dat", "r"); // open readonly // numbers
  foreach (line; f.byLine) {               // are kept in text mode)
    if (line.matchFirst(regex(`^$`))) { // empty line?
      i++;   // toggle to the second half of the data
    } else {
      d[i] ~= line.idup.splitter(sep[i]).array;
    }
  }
 
  foreach(sm; d[1]) {    // each safety manual
    bool page_modified = false, page_ok = false;
    do {
      page_ok = true;
      string [][] tpo;     // triggered page order pair
    recheck:
      foreach(j, p; sm) {  // each safety manual page
	foreach(o; d[0]) { // each page order pair
	  if (p == o[1]) { // if the 'after' page of the order
	    tpo ~= o ~ j.to!string;      // ... the 'before' is now forbidden
	  }
	  foreach (k, po; tpo) { // k -> loop counter
	    if (po[0] == p) {
	      sm.swapAt(po[2].to!int, j);
	      tpo.remove(k);
	      page_ok = false;
	      page_modified = true;
	      break recheck;
	    }
	  }
	}
      }
    } while (!page_ok);
    
    if (page_modified) {
      iou += sm[sm.length / 2].to!int;
    } 
  }
  writeln("Incorrectly ordered updates score:  " ~ iou.to!string);
}

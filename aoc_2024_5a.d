#!/usr/bin/rdmd

/+ Advent of Code 2024 Day 5 Part 1 +/

import std.stdio;
import std.conv;
import std.algorithm;
import std.array;
import std.regex;

void main() {

  int iou = 0; // incorrectly ordered updates score 
  int i = 0;               // index
  char[] sep = ['|', ',']; // 'record' separators
  string[][][2] d;         // data
  auto f = File("aoc_2024-5.dat", "r"); // open readonly
  foreach (line; f.byLine) {
    if (line.matchFirst(regex(`^$`))) { // empty line?
      i++;   // toggle to the second half of the data
    } else {
      d[i] ~= line.idup.splitter(sep[i]).array;
    }
  }
  
  foreach(sm; d[1]) {    // each safety manual
    bool page_ok = true;
    string [] dfp;       // forbidden pages
  next_pair:
    foreach(p; sm) {     // each safety manual page
      foreach(o; d[0]) { // each page order pair
	if (p == o[1]) { // if the 'after' page of the order
	  dfp ~= o[0];   // ... the 'before' is now forbidden
	}
	if (dfp.canFind(p)) {
	  page_ok = false;
	  break next_pair;
	}
      }
    }
    if (page_ok) {
      iou += sm[sm.length / 2].to!int;
    } 
  }
  writeln("Incorrectly ordered updates score:  " ~ iou.to!string);
}

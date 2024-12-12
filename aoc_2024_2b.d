#!/usr/bin/rdmd

/+ Advent of Code 2024 Day 2 Part 2 +/

import std.stdio;
import std.conv;
import std.algorithm;
import std.array;
import std.math.algebraic; // abs
import std.math.traits;    // sgn

void main(string[] args) {

  int tsls = 0; // total safe levels
  auto f = File("aoc_2024-2.dat", "r"); // open readonly
  foreach (line; f.byLine) {
    string[] r = line.idup.splitter(' ').array; // record
  record:
    for (int skip = 0; skip < r.length; skip++) { // a safe record
      // will still be safe even if the first level is removed
      bool ar = false;   // active report
      bool sl = true;    // safe level
      int lp;            // previous level
      int pdir = 0;      // previous direction
      foreach(j, l; r) { // level
	if (skip != j) { // level to skip
	  if (ar == true) {
	    if (abs(lp - l.to!int) < 1 || abs(lp - l.to!int) > 3) {
	      sl = false;
	    }
	    else if (pdir != 0 && (sgn(lp - l.to!int) != pdir)) {
	      sl = false;
	    }
	    pdir = sgn(lp - l.to!int);
	  }
	  lp = l.to!int; // save current level as previous
	  ar = true;
	}
      }
      if (sl == true) {
	tsls++;
	break record;
      }
    }
  }
  f.close();
  writeln(tsls);
}

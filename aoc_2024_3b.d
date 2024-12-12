#!/usr/bin/rdmd

/+ Advent of Code 2024 Day 3 Part 2 +/

import std.stdio; // Note: For part 2 I put a "do()"
import std.file;  //  in the start of the data manually
import std.conv;  //  to turn on the multiplication
import std.array; //  and eliminate a test 
import std.regex;

void main(string[] args) {

  auto r = regex(`mul\(\d{1,3},\d{1,3}\)`);

  int sem = 0; // sum of all enabled multiplications
  string t = "aoc_2024-3.dat".readText;
  foreach (m; t.idup.splitter(regex(`don't\(\)`)).array) {
    foreach (em; m.matchAll(regex(`do\(\)([\S\s]*)`))) {
      if (!em.empty) {
	foreach (c; em[1].matchAll(r)) {
	  auto d = c.hit.matchAll(regex(`(\d{1,3}),(\d{1,3})`)).array;
	  sem += d[0][1].to!int * d[0][2].to!int;
	}
      }
    }
  }
  writeln(sem);
}

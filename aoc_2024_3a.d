#!/usr/bin/rdmd

/+ Advent of Code 2024 Day 3 Part 1 +/

import std.stdio;
import std.file;
import std.conv;
import std.array;
import std.regex;

void main(string[] args) {

  auto r = regex(`mul\(\d{1,3},\d{1,3}\)`);

  int sem = 0; // sum of all enabled multiplications
  string t = "aoc_2024-3.dat".readText;
  foreach (c; t.matchAll(r)) {
    auto d = c.hit.matchAll(regex(`(\d{1,3}),(\d{1,3})`)).array; 
    sem += d[0][1].to!int * d[0][2].to!int;
  }
  writeln(sem);
}

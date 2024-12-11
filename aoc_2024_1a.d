#!/usr/bin/rdmd

/+ Advent of Code 2024 Day 1 Part 1 +/

import std.stdio;
import std.conv;
import std.algorithm;
import std.regex;
import std.array;
import std.math.algebraic;

void main(string[] args) {

  int[] ll, rl; // left list, right list
  auto f = File("aoc_2024-1.dat", "r"); // open readonly
  foreach (line; f.byLine) {
    string[] s = line.idup.splitter(regex(`\s+`)).array;
    ll ~= s[0].to!int;
    rl ~= s[1].to!int;
  }
  f.close();

  ll.sort();
  rl.sort();

  int td; // total distance
  for (int i = 0; i < ll.length; i++) {
    td += abs(ll[i] - rl[i]);
  }
  writeln(td);
}

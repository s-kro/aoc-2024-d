#!/usr/bin/rdmd

/+ Advent of Code 2024 Day 4 Part 1 +/

import std.stdio;
import std.conv;
import std.algorithm;
import std.array;

void main() {
  char[][] grid;
  auto f = File("aoc_2024-4.dat", "r"); // open readonly
  size_t l;
  foreach (line; f.byLine) {
    l = line.idup.length;
    grid ~= "..." ~ line ~ "..."; // pad out the array horizonatally
  }
  f.close();

  char[] p;
  foreach (i; 0 .. l + 6) { p ~= '.'; }
  size_t w = grid[].length;
  grid = [p, p, p] ~ grid ~ [p, p, p]; // ... and vertically

  int[][] sv = [[0, -1], [1, -1], [1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1]];
  int fw = 0; // found words

  foreach (i; 3 .. w + 3) {
    foreach (j; 3 .. l + 3) {
      foreach (v; sv) { // vector
	bool test = true;
	foreach (k; 0 .. 4) {
	  if ("XMAS".array[k] != grid[i + v[0] * k][j + v[1] * k]) {
	    test = false;
	    break;
	  }
	}
	if (test) {
	  fw++;
	}
      }
    }
  }
  writeln("XMAS found " ~ fw.to!string ~ " times");
}

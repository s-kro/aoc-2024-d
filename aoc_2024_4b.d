#!/usr/bin/rdmd

/+ Advent of Code 2024 Day 4 Part 2 +/

import std.stdio;
import std.conv;
import std.algorithm;
import std.array;

void main() {
  char[][] grid;
  auto f = File("aoc_2024-4.dat", "r"); // open readonly
  foreach (line; f.byLine) {
    grid ~= line.dup;
  }
  f.close();

  int fw = 0; // found words
  size_t w = grid[].length - 1;
  
  foreach (i; 1 .. grid.length - 1) {
    foreach (j; 1 .. grid[i].length - 1) {
      if (grid[i][j] == 'A' && // 'anchor' on A and look around
	  ((grid[i - 1][j - 1] == 'M' && grid[i + 1][j + 1] == 'S') ||
	   (grid[i - 1][j - 1] == 'S' && grid[i + 1][j + 1] == 'M')) &&
	  ((grid[i + 1][j - 1] == 'M' && grid[i - 1][j + 1] == 'S') ||
	   (grid[i + 1][j - 1] == 'S' && grid[i - 1][j + 1] == 'M'))) {
	fw++;
      }
    }
  }
  writeln("X-MAS found " ~ fw.to!string ~ " times");
}

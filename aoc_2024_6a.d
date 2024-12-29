#!/usr/bin/rdmd

/+ Advent of Code 2024 Day 6 Part 1 +/

import std.stdio;
import std.string;
import std.conv;
import std.algorithm;
import std.array;
import std.typecons;

struct point {int x, y; char d;}

void main() {

  int pv = 1; // positions visited (already count the starting position)
  int i = 0;          // index
  char[][] g;         // grid
  point p = {x:0, y:0, d:'^'}; // position and direction
  auto f = File("aoc_2024-6.dat", "r"); // open readonly
  foreach (line; f.byLine) {
    if (line.indexOf('^') != -1) { // found guard's starting position
      p.x = line.indexOf('^').to!int;
      p.y = i;
    }
    g ~= line.dup;
    i++;
  }

  int[][char] np = ['^' : [-1, 0], '>' : [0, 1],'v' : [1, 0], '<' : [0, -1]]; // next position
  char[char]  nd = ['^' : '>', '>' : 'v', 'v' : '<', '<' : '^'];              // next direction

  do {
    g[p.y][p.x] = 'X'; // leave a breadcrumb

    if (g[p.y + np[p.d][0]][p.x + np[p.d][1]] == '#') { // obstacle?
      p.d = nd[p.d]; // make our turn (save our new direction)
    }
    p.y += np[p.d][0];
    p.x += np[p.d][1];
    if (g[p.y][p.x] != 'X') { // check to make sure we haven't been here before
      pv++;
    }
  } while (on_grid(p, g.length, g[].length));
  
  writeln("Guard has visited " ~ pv.to!string ~ " positions");
}

bool on_grid(point p,  ulong l, ulong w)
{ // return false if the point is outside of the grid
  return ((p.d != 'v' || p.y != l - 1) && (p.d != '>' || p.x != w - 1) &&
	  (p.d != '^' || p.y != 0)     && (p.d != '<' || p.x != 0));
}

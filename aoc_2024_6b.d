#!/usr/bin/rdmd

/+ Advent of Code 2024 Day 6 Part 2 +/

import std.stdio;
import std.string;
import std.conv;
import std.algorithm;
import std.array;
import std.typecons;

struct point {int x, y; char d;}

void main() {

  int op = 0; // obstacles placed 
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
    point   lp = p; // loop position
    point[] lo;     // loop obstacles
    if (g[lp.y + np[lp.d][0]][lp.x + np[lp.d][1]] == '#') {
      lp.d = nd[lp.d]; // make sure we don't have to make a turn
    }
    point o = {lp.x + np[lp.d][1], lp.y + np[lp.d][0], 'O'}; // then place a new obstacle

    if (g[o.y][o.x] != 'X') { // can't place an obstacle on a place we've already been
      lp.d = nd[lp.d];        // ... otherwise there is a new obstacle so we turn
      do {
	bool dobst = false;
	if (g[lp.y + np[lp.d][0]][lp.x + np[lp.d][1]] == '#' ||
	  (lp.y + np[lp.d][0] == o.y && lp.x + np[lp.d][1] == o.x)) {     // obstacle?
	  if (g[lp.y + np[nd[lp.d]][0]][lp.x + np[nd[lp.d]][1]] == '#' || // second obstacle?
	      (lp.y + np[nd[lp.d]][0] == o.y && lp.x + np[nd[lp.d]][1] == o.x)) { // so we need a u turn
	    dobst = true;                             // ... note: a triple turn (270 deg) is impossible
	  }
	  if (lo.canFind(lp)) { // we're in a loop
	    op++;
	    break;
	  }
	  lo ~= lp; // save our point before we make our turn
	  if (dobst) {lp.d = nd[lp.d];}
	  lp.d = nd[lp.d]; // make our turn (save our new direction)

	}
	lp.y += np[lp.d][0];
	lp.x += np[lp.d][1];
      } while (on_grid(lp, g.length, g[].length));
    } 
    
    if (g[p.y + np[p.d][0]][p.x + np[p.d][1]] == '#') { // obstacle?
      p.d = nd[p.d]; // make our turn (save our new direction)
    }
    p.y += np[p.d][0];
    p.x += np[p.d][1];
    g[p.y][p.x] = 'X'; // leave a breadcrumb

  } while (on_grid(p, g.length, g[].length));
  writeln("We can place " ~ op.to!string ~ " obstacles");
}

bool on_grid(point p,  ulong l, ulong w)
{ // return false if the point is outside of the grid
  return ((p.d != 'v' || p.y != l - 1) && (p.d != '>' || p.x != w - 1) &&
	  (p.d != '^' || p.y != 0)     && (p.d != '<' || p.x != 0));
}

#! /usr/bin/env ruby
# -*- mode: ruby; mode: viper; -*-

# Operation        Array              Hash

# destructive      a1 << one_elem     h1.merge!({key=>value})
# append/overlay   a1 += a2           h1.merge!(h2)
# (modifies left-hand side, right-hand side not modified)
#
# non-destructive  a1 + a2            h1.merge(h2)
# append/overlay
#
# copy             a1 = Array.new(a2) h1={}.merge(h2)
#                                     h1=h2.merge({})
# (Now modifications to a1/h1 does not affect a2/h2, and vice versa.)

  if cond1
    stuff1
[ elsif cond2
    stuff2 ]
[ elsif cond3
    stuff3 ]
[ else
    else_stuff ]
  end

  unless cond
    stuff1
[ else
    else_stuff ]
  end

  case target
  when comparison [, comparison ]
    body
  when comparison [, comparison ]
    body
[ else
    body ]
  end

# Inside loop bodies, you can use these keywords:

# break [ expr ] - like C's break, Perl's last, expr returned as value of loop if present, otherwise value of loop is nil

# next [ expr ] - like C's continue, Perl's next.  Does expr really mean anything?  Maybe only if it interrupts the last loop iteration?

# redo - repeats the loop from the start, but without reevaluating the condition or fetching the next element (in an iterator)

# retry - restarts the loop, reevaluating the condition

while cond
  body
end

until cond
  body
end

for name [, name]... in expression
  body
end

# Above for is executed as if it were the following each loop, except
# that local varaibles defined in the body of the for loop will be
# available outside the loop, and those defined within an iterator
# block will not.

expression.each do | name [, name]... |
  body
end

loop do
  body
end


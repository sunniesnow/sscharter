# Useful tools bundled with sscharter

You can put `include Sunniesnow::Tools` in your code to make the tools available everywhere.

## SVG path

The tools provide a function `path` that can turn any SVG path into uniformly sampled points.
For example, consider this fancy-looking SVG path:

```xml
<svg width="16cm" height="8cm" viewBox="-8 -4 16 8"><g transform="scale(1,-1)"><path
d="M -6,-0 C -4,2 -0,-0.7 -0,2 -0,4.7 6,-1 5,1 4,3 1,2 -0,-0 -1,-2 10,-2 6,-3 2,-4 -6,-0 -4,2 c 2,2 3,-8 0,-5"
fill="none" stroke="black" stroke-width="0.1"/></g></svg>
```

![Example SVG path](https://i.imgur.com/lnrOPUU.png)

You can convert it to a set of points using the `path` function lik this:

```ruby
path 'M -6,-0 C -4,2 -0,-0.7 -0,2 -0,4.7 6,-1 5,1 4,3 1,2 -0,-0 -1,-2 10,-2 6,-3 2,-4 -6,-0 -4,2 c 2,2 3,-8 0,-5', 128 do |x, y, i|
	d x, y; b 1/32r
end
```

![SVG path converted to points](https://i.imgur.com/VPKHX1q.png)

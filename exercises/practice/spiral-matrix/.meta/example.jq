# create an n x n matrix containing all zeroes
def make_matrix($n):
  def fill($n; $elem): reduce range($n) as $i ([]; . + [$elem]) ;
  fill($n; fill($n; 0))
;


.size as $n
| {matrix: make_matrix($n), x: 0, y: 0, dx: 0, dy: 1, i: 1}
| until(.i > $n * $n;
    .matrix[.x][.y] = .i
    | if  .x + .dx < 0 or .x + .dx == $n or
          .y + .dy < 0 or .y + .dy == $n or
          .matrix[.x + .dx][.y + .dy] != 0
      then
        . + {dx: .dy, dy: -.dx}
      end
    | .x += .dx
    | .y += .dy
    | .i += 1
  )
| .matrix

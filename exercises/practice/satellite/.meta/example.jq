# Determine if an array contains only unique elements
# input: an array
# output: boolean
def is_unique:
    . as $a
    | reduce .[] as $e (true; . and ($a | indices([$e]) | length) == 1)
;

# Validate that the input preorder and inorder arrays
# contain unique elements
def validate_unique:
    if (.preorder | is_unique) and (.inorder | is_unique)
    then .
    else "traversals must contain unique items" | halt_error
    end
;

# Validate that the input preorder and inorder arrays
# have the same length
def validate_length:
    if (.preorder | length) == (.inorder | length)
    then .
    else "traversals must have the same length" | halt_error
    end
;

# Validate that the input preorder and inorder arrays
# have the same elements.
#
# Determining if an array contains an element is annoying in jq.
#     ["foo"] | inside(["bar", "foo", "qux"])
# is true, but so is
#     ["foo"] | inside(["bar", "foolish", "qux"])
# because the **array** `inside` does a reduction of the **string** `inside`
#
# Fortunately, this recipe works to examine the two arrays entirely
# instead of iterating over them.
#
def validate_elements:
    .inorder as $inorder
    | if (.preorder | inside($inorder)) and (.preorder | contains($inorder))
      then .
      else "traversals must have the same elements" | halt_error
      end
;

############################################################
# Construct the tree recursively, given the input {preorder, inorder} object
def build_tree:
    validate_length
    | validate_elements
    | if (.preorder | length) == 0
      then {}
      else
          # The first value of preorder is the root of the tree.
          # Then find its index in inorder and split apart the arrays.
          #
          .preorder[0]                  as $root
          | (.inorder | indices($root)) as [$idx]
          | .inorder[:$idx]             as $i_l
          | .inorder[$idx+1:]           as $i_r
          | ($i_l | length)             as $len
          | .preorder[1:$len+1]         as $p_l
          | .preorder[$len+1:]          as $p_r
          | {
              v: $root,
              l: ({preorder: $p_l, inorder: $i_l} | build_tree),
              r: ({preorder: $p_r, inorder: $i_r} | build_tree)
            }
      end
;

############################################################
validate_unique | build_tree

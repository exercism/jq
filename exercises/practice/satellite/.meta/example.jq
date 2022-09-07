def assert(cond; errmsg):
    if cond then . else (errmsg | halt_error) end;

def validate_unique:
    def is_unique: length == (unique | length);

    assert((.preorder | is_unique) and (.inorder | is_unique);
           "traversals must contain unique items");

def validate_length:
    assert((.preorder | length) == (.inorder | length);
           "traversals must have the same length");

def validate_elements:
    assert((.preorder | sort) == (.inorder | sort);
           "traversals must have the same elements");

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
          | .inorder[:$idx]             as $in_l
          | .inorder[$idx+1:]           as $in_r
          | ($in_l | length)            as $len
          | .preorder[1:$len+1]         as $pre_l
          | .preorder[$len+1:]          as $pre_r
          | {
              v: $root,
              l: ({preorder: $pre_l, inorder: $in_l} | build_tree),
              r: ({preorder: $pre_r, inorder: $in_r} | build_tree)
            }
      end;

############################################################
validate_unique | build_tree

def encode:
    ascii_upcase | explode | sort;

def matches($subj; $code):
    (ascii_upcase != $subj) and (encode == $code);

(.subject | [ascii_upcase, encode]) as [$subj_uc, $subj_code]
| .candidates
| map(select(matches($subj_uc; $subj_code)))

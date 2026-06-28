#!/usr/bin/env bats

load fixture

@test "truncation of text and monotonically decreasing numbers from 10 in tab-separated input truncates at 5" {
    run -0 truncateLongTail --field-separator $'\t' 2 <<'EOF'
at least ten	10	animals
nine	9	goods
eight	8	boxes
seven	7	cars
six or more	6	bicycles
five	5	men
probably four	4	computers
three or less	3	sets
two	2	fingers
one	1	woman
EOF
    assert_output - <<'EOF'
at least ten	10	animals
nine	9	goods
eight	8	boxes
seven	7	cars
six or more	6	bicycles
five	5	men
EOF
}

@test "truncation of text and monotonically decreasing numbers from 10 in comma-separated input truncates at 5" {
    run -0 truncateLongTail --field-separator , 2 <<'EOF'
ten,10,animals
nine,9,goods
eight,8,boxes
seven,7,cars
six,6,bicycles
five,5,men
four,4,computers
three,3,sets
two,2,fingers
one,1,woman
EOF
    assert_output - <<'EOF'
ten,10,animals
nine,9,goods
eight,8,boxes
seven,7,cars
six,6,bicycles
five,5,men
EOF
}

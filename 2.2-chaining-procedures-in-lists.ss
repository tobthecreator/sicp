(define test (list 1 2 3 4 5 6 7 8 9 10))

(
    define 
    (test-proc x) 
    (> x 5)
)

(
    define
    (filter proc l)
    (
        if (null? l)
        (list)
        (
            if (proc (car l))
            (
                append 
                (list (car l))
                (filter proc (cdr l))
            )
            (
                filter proc (cdr l)
            )
        )
    )
)

(
    define 
    (filter-above-5 l)
    (
        
        filter 
        (
            lambda
            (x)
            (> x 5)
        ) 
        l
    )
)

(
    define 
    (square-list l)
    (
        map
        (
            lambda
            (x)
            (* x x)
        )
        l
    )
)

; alright the chaining we know about so far

(
    square-list
    (
        filter-above-5
        test
    )
)

; works!

; okay so let's think about this with a list

(
    define 
    proc-list 
    (list filter-above-5 square-list)
)

(
    define
    (chain pl l)
    (
        map
        (
            lambda
            (p)
            (p l)
        )
        pl
    )
)

(
    define
    (chain-2 pl l)
    (
        if (or (null? pl) (null? l))
        l ; empty list worst case
        (
            (car pl) ; this will be pl[i]
            (
                chain-2 (cdr pl) l
            )
        )
    )
)


; i need to reverse this a bit.  what i got was an array of the results for each individual function

; okay they're now properly chaining, but they're chaining in reverse order which is funny

; ideally to me the api here is "run these in this order"

; not "run this in the way you'd write this"

; so we could obviously reverse it

; or we can change the format

(
    define
    (chain-3 pl l)
    (
        if (null? (cdr pl)) ; if you are the last function
        ((car pl) l)
        (
            ;(car pl) ; this will be pl[i]
            
            chain-3 (cdr pl) ((car pl) l)
            
        )
    )
)

(chain-3 proc-list test)

; hey siri, play i am a god
; (hurry-up damn-croissant)

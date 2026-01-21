(defun merge-lists-spinning-pairs (lst1 lst2)
  (cond
    ((and (null lst1) (null lst2)) nil)
    ((null lst2) (list (list (car lst1))))
    ((null lst1) (list (list (car lst2))))
    (t (cons (list (car lst1) (car lst2))
             (merge-lists-spinning-pairs (cdr lst2) (cdr lst1))))))

(defun check-first-reverse (name lst1 lst2 expected)
  "Execute `merge-lists-spinning-pairs' on `lst1' and `lst2', compare result with `expected'"
  (format t "~:[FAILED~;passed~] ~a~%"
          (equal (merge-lists-spinning-pairs lst1 lst2) expected)
          name))

(defun test-first-reverse ()
  (check-first-reverse "test 1" 
                       '(1 2 3) '(a b c) '((1 a) (b 2) (3 c)))
  
  (check-first-reverse "test 2" 
                       '(1 2) '(a b c d)  '((1 a) (b 2) (c)))
  
  (check-first-reverse "test 3" 
                       '(1 2 3) nil  '((1)))

  (check-first-reverse "test 4" 
                       nil nil nil)

  (check-first-reverse "test 5" 
                       nil '(4)  '((4))))

(defun list-set-intersect-p (lst1 lst2)
  (cond
    ((null lst1) nil)
    ((member (car lst1) lst2) t)
    (t (list-set-intersect-p (cdr lst1) lst2))))

(defun check-intersect (name lst1 lst2 expected)
  "Execute `list-set-intersect-p' on `lst1' and `lst2', compare result with `expected'"
  (format t "~:[FAILED~;passed~] ~a~%"
          (equal (list-set-intersect-p lst1 lst2) expected)
          name))

(defun test-intersect ()
  (check-intersect "task 2 test 1 " 
                   '(1 2 3) '(4 5 6) nil)
  
  (check-intersect "task 2 test 2 " 
                   '(1 2 3) '(3 4 5) t))

(defun test-lab-tasks ()
  (test-first-reverse)
  (test-intersect))

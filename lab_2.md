<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 2</b><br/>
"Рекурсія"<br/>
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right"><b>Студент</b>: Іван Олегович Гуров</p>
<p align="right"><b>Рік</b>: 2026</p>

## Загальне завдання

Реалізувати дві рекурсивні функції, що виконують деякі дії з вхідним(и) списком(-ами), за можливості/необхідності використовуючи різні види рекурсії. Вимоги:
1. Зміна списку має відбуватись за рахунок конструювання нового списку
2. Не використовувати функції вищого порядку чи стандартні функції для роботи зі списками, що не наведені в четвертому розділі навчального посібника
3. Функція не має бути функцією вищого порядку
4. Не використовувати псевдофункції (деструктивний підхід)
5. Не використовувати цикли

## Варіант 6

**Завдання 1:** Написати функцію `merge-lists-spinning-pairs`, яка групує відповідні елементи двох списків, почергово змінюючи їх взаємне розташування в групі:
```lisp
CL-USER> (merge-lists-spinning-pairs '(1 2 3 4 5) '(a b c d))
((1 A) (B 2) (3 C) (D 4) (5))
```

**Завдання 2:** Написати предикат `list-set-intersect-p`, який визначає чи перетинаються дві множини, задані списками атомів:
```lisp
CL-USER> (list-set-intersect-p '(1 2 3) '(4 5 6))
NIL
CL-USER> (list-set-intersect-p '(1 2 3) '(3 4 5))
T
```

## Лістинг функції merge-lists-spinning-pairs

```lisp
(defun merge-lists-spinning-pairs (lst1 lst2)
  (cond
    ((and (null lst1) (null lst2)) nil)
    ((null lst2) (list (list (car lst1))))
    ((null lst1) (list (list (car lst2))))
    (t (cons (list (car lst1) (car lst2))
             (merge-lists-spinning-pairs (cdr lst2) (cdr lst1))))))
```

### Тестові набори та утиліти

```lisp
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
```

### Тестування

```lisp
CL-USER> (test-first-reverse)
passed test 1
FAILED test 2
passed test 3
passed test 4
passed test 5
NIL
```

## Лістинг функції list-set-intersect-p

```lisp
(defun list-set-intersect-p (lst1 lst2)
  (cond
    ((null lst1) nil)
    ((member (car lst1) lst2) t)
    (t (list-set-intersect-p (cdr lst1) lst2))))
```

### Тестові набори та утиліти

```lisp
(defun check-intersect (name lst1 lst2 expected)
  "Execute `list-set-intersect-p' on `lst1' and `lst2', compare result with `expected'"
  (format t "~:[FAILED~;passed~] ~a~%"
          (equal (list-set-intersect-p lst1 lst2) expected)
          name))

(defun test-intersect ()
  (check-intersect "task 2 test 1" 
                   '(1 2 3) '(4 5 6) nil)
  
  (check-intersect "task 2 test 2" 
                   '(1 2 3) '(3 4 5) t))
```

### Тестування

```lisp
CL-USER> (test-intersect)
passed task 2 test 1
passed task 2 test 2
NIL
```

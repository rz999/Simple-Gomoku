#lang racket
;;last modified mar-26-2017 11:00 pm
(require racket/gui/base)
(require pict images/icons/control images/icons/style)
(require images/icons/symbol)
;;(require racket/draw)
;;(require images/icons/misc)
;;(require images/icons/stickman)
;;(require games/gl-board-game)
;;(require lang/posn htdp/draw)



;;color database
;;https://docs.racket-lang.org/draw/color-database___.html

;;create the frame
;;https://docs.racket-lang.org/gui/frame_.html?q=frame
(define frame (new frame%
                   
                   [label "Simple Gomoku"] 
                   [width 600]
                   [height 750]))

;;xlz's exolire_gui_mouse_event starts
;;x,y coords
(define msg1 (new message% [parent frame]
                          [label "(x-coord, y-coord)"]))
;;read mouse coords
(define my-canvas%
  (class canvas% ; The base class is canvas%
    ; Define overriding method to handle mouse events
    (define/override (on-event event)
      (send msg1 set-label (string-append (string-append (number->string (send event get-x)) ", ") (number->string(send event get-y)))))
    (super-new)))
;;xlz's exolire_gui_mouse_event ends


(new my-canvas% [parent frame]
             [paint-callback
              (lambda (canvas dc)
                (send dc set-scale 10 10)
                ;;(send dc set-text-foreground "blue")
                ;;(send dc draw-text "Don't Panic!" 0 0)
                (send dc set-pen "black" 0.25 'solid)
                (let loop ((times 15))
                  (if (= times 0)
                      (display "stopped")
                      (begin (send dc draw-line (* 4 times) 0 (* 4 times) (* 4 15))
                             (loop (- times 1)))))
                (let loop ((times 15))
                  (if (= times 0)
                      (display "stopped")
                      (begin (send dc draw-line 0 (* 4 times) (* 4 15) (* 4 times))
                             (loop (- times 1)))))
                )])

;; Make a static text message in the frame
(define msg (new message% [parent frame]
                          [label "Please Start the Game!"]))

;;(text-icon "Please Start the Game!"
             ;;(make-font #:weight 'normal #:underlined? #f)
             ;;#:color "Black" #:height 24)


 
;; Make a button in the frame
;;https://docs.racket-lang.org/gui/button_.html

;;text icon(strat/stop)
;;http://docs.racket-lang.org/images/Icons.html#%28part._.About_.These_.Icons%29

;;make font
;;;;http://docs.racket-lang.org/draw/Drawing_Functions.html#%28def._%28%28lib._racket%2Fdraw..rkt%29._make-font%29%29
(new button% [parent frame]
             [label (text-icon "Start!"
             (make-font #:weight 'normal #:underlined? #f)
             #:color "Green Yellow" #:height 25)]
             ; Callback procedure for a button click:
             [callback (lambda (button event)
                         (send msg set-label "Gomoku Started"))])

(new button% [parent frame]
             [label (text-icon "Stop!"
             (make-font #:weight 'normal #:underlined? #f)
             #:color "Orange Red" #:height 30)]
             ; Callback procedure for a button click:
             [callback (lambda (button event)
                         (send msg set-label "Gomoku Stopped"))])

;;As an example, here is how to duplicate the record-icon using pict

;;black/white
(define outline-colorw (icon-color->outline-color "white"))
 (define brush-pictw (colorize (filled-ellipse 20 20) "white"))
 (define pen-pictw (linewidth 2 (colorize (ellipse 20 20) outline-colorw)))
 (bitmap-render-icon
   (pict->bitmap (inset (cc-superimpose brush-pictw pen-pictw) 1))
   5/8 glass-icon-material)

(define outline-colorb (icon-color->outline-color "black"))
 (define brush-pictb (colorize (filled-ellipse 20 20) "black"))
 (define pen-pictb (linewidth 2 (colorize (ellipse 20 20) outline-colorb)))
 (bitmap-render-icon
   (pict->bitmap (inset (cc-superimpose brush-pictb pen-pictb) 1))
   5/8 glass-icon-material)


;;mouse event mar-26-2017

;;(new mouse-event%	 
   	 ;;	[event-type 'left-down]
           ;;     )


;;next step
;;chaneg the bgc
;;put the chess onto the board
;;move the chess
;;AI Algothrim
;;UI
(send frame show #t)

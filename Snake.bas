rem Snake 1.00
rem (C)2024 Cretu Gheorghe-Andrei

nomainwin
[variables]
Global x,y  'snake head coords
Dim a(1602,2) 'path
dim b(1602,2) 'elements
Global i,j  'indexes
Global c,d,e 'counters
Global food 'boolean
Global foodx,foody 'food coordinates
Global up,down,left,right
Global score,level
Global i$

[initializeVariables]
let UpperLeftX=0: let UpperLeftY=0
let WindowWidth=860 : let WindowHeight=640
let x=400 : let y=200
let i=1 :let j=3
let c=0:let d=0:let e=0
let food=0
let foodx=-20:let foody=-20
let up=0
let down=0
let left=0
let right=1
let score=0:let level=1
let i$=""

[resources]
    graphicbox #1.1, 0,0,800,400
    statictext #1.status,"Score:";score;" Level:";level,0,430,100,25
[window]
    open "Snake 1.00 for Windows" for window_nf as #1
        print #1, "trapclose [quit]"
        #1.status, "!font Arial 10 Normal"
        #1.1, "home ; down"
        #1.1, "fill black;backcolor black; color Green"
        #1.1, "place 0 30"
        #1.1, "|Snake 1.00 for Windows"
        #1.1, "|(C)2024 Cretu Gheorghe-Andrei"
        #1.1, "|"
        #1.1, "|Use lowercase:"
        #1.1, "|w-up"
        #1.1, "|s-down"
        #1.1, "|d-right"
        #1.1, "|a-left"
        #1.1, "|"
        #1.1, "|Eat food and don't bite your tail"
        #1.1, "|"
        #1.1, "|Press any key to play..."
        #1.1, "setfocus"
        #1.1, "when characterInput [keyDown]"
    wait

[loop]
    #1.1, "setfocus"
    scan
    
    if up=1 then let y=y-20
    if down=1 then let y=y+20
    if left=1 then let x=x-20
    if right=1 then let x=x+20
    
    if x>780 then let x=0
    if x<0 then let x=780
    if y>380 then let y=0
    if y<0 then let y=380
    let a(i,1)=x : let a(i,2)=y
    let d=i
    
    if not(food) then gosub [food_generator]
    call Pause 1024-(level*100)
    #1.1, "fill Black"
    for c=1 to j step 1
        let b(c,1)=a(d,1)
        let b(c,2)=a(d,2)
        if d>j then let d=d-1
        if d<=j then exit for
        'The Snake
        #1.1,"place ";b(c,1);" ";b(c,2)
        #1.1,"backcolor darkgreen; color green"
        #1.1,"boxfilled ";b(c,1)+20; " ";b(c,2)+20
        'The food
        #1.1, "place ";foodx ; " ";foody
        #1.1, "backcolor darkred; color red"
        #1.1, "boxfilled ";foodx+20;" ";foody+20
        'The game status
        #1.status, "Score:";score;" Level:";level
        
    next    
    let i=i+1
    if i>1601 then let i=1
    
    if x>=foodx-20 and x<=foodx+20 and y>=foody-20 and y<=foody+20 then gosub [eat]
    
    for e=j to 2 step -1
        if x=b(e,1) and y=b(e,2) then goto [game_over]
    next    
goto [loop]

[keyDown]
    let i$=Inkey$
    if i$="w" then gosub [up]
    if i$="s" then gosub [down]
    if i$="d" then gosub [right]
    if i$="a" then gosub [left]
    if i$=chr$(27) then [quit]
    
    

goto [loop]

[up]
    let up=1
    let down=0
    let left=0
    let right=0
return

[down]
    let up=0
    let down=1
    let left=0
    let right=0
return

[left]
    let up=0
    let down=0
    let left=1
    let right=0
return


[right]
    let up=0
    let down=0
    let left=0
    let right=1
return

[food_generator]
    let food=1
    let foodx=int(rnd(1)*780) : let foody=int(rnd(1)*380)
return

[eat]
    let score=score+level
    let food=0
    let j=j+1
    if (j mod (level*10))=1 then gosub [nextlevel]
return

[nextlevel]
    let level=level+1
    if level>10 then let level=1
    let j=3
return


[game_over]
notice "**Game Over!**"
call Pause 1000


[quit]
    close #1
    end                  
    
sub Pause mil
    let t = time$("ms")
    while time$("ms")<t+mil
    wend
end sub                                     

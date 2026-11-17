turtles-own [
  cuarentena?   ;; true = la persona permanece inmovil
]

to setup
  clear-all
  create-turtles num-personas [
    setxy random-xcor random-ycor
    set shape "person"
    set color green          ;; verde = sano
    set cuarentena? false
  ]
  ;; porcentaje de personas en cuarentena
  ask n-of round (num-personas * porcentaje-cuarentena / 100) turtles [
    set cuarentena? true
  ]
  ;; un infectado inicial (rojo)
  ask one-of turtles [ set color red ]
  reset-ticks
end

to go
  ;; condiciones de parada
  if all? turtles [ color = red ] [ stop ]
  if ticks >= 500 [ stop ]

  ;; movimiento: solo se mueven los que NO estan en cuarentena
  ask turtles with [ not cuarentena? ] [
    rt random 360
    fd 1
  ]

  ;; contagio: los rojos infectan a los verdes cercanos
  ask turtles with [ color = red ] [
    ask other turtles in-radius radio-contagio with [ color = green ] [
      set color red
    ]
  ]
  tick
end
@#$#@#$#@
GRAPHICS-WINDOW
230
10
667
448
-1
-1
13.0
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
15
20
90
53
setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
110
20
185
53
go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
15
70
187
103
num-personas
num-personas
10
1000
300.0
10
1
NIL
HORIZONTAL

SLIDER
15
110
187
143
porcentaje-cuarentena
porcentaje-cuarentena
0
100
0.0
10
1
%
HORIZONTAL

SLIDER
15
150
187
183
radio-contagio
radio-contagio
1
5
1.0
1
1
NIL
HORIZONTAL

MONITOR
15
195
100
240
infectados
count turtles with [color = red]
17
1
11

MONITOR
110
195
195
240
sanos
count turtles with [color = green]
17
1
11

PLOT
15
255
210
430
Contagio
ticks
personas
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"infectados" 1.0 0 -2674135 true "" "plot count turtles with [color = red]"
"sanos" 1.0 0 -10899396 true "" "plot count turtles with [color = green]"

@#$#@#$#@
## QUE ES

Modelo basado en agentes de propagacion de una infeccion con cuarentena. Los agentes sanos (verdes) se mueven al azar; un agente infectado (rojo) contagia a los sanos que estan dentro de su radio de contagio.

## COMO USARLO

1. Elija num-personas, porcentaje-cuarentena y radio-contagio.
2. Pulse setup y luego go.
3. La simulacion se detiene cuando todos estan infectados o al llegar a 500 ticks.

## EXPERIMENTO

BehaviorSpace -> experimento "cuarentena": varia porcentaje-cuarentena de 0 a 80 (paso 20), 10 repeticiones. Exporte los resultados en formato TABLE (CSV).
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105
@#$#@#$#@
NetLogo 6.4.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="cuarentena" repetitions="10" sequentialRunOrder="true" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="500"/>
    <metric>count turtles with [color = red]</metric>
    <steppedValueSet variable="porcentaje-cuarentena" first="0" step="20" last="80"/>
    <enumeratedValueSet variable="num-personas">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="radio-contagio">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@

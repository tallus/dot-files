<CsoundSynthesizer>
<CsOptions>
-o dac			; output to soudcard
</CsOptions>
<CsInstruments>
sr = 44100		; sample rate (CD quality)
kr = 4410		; control rate 
ksmps = 10		; numbers of samples per control period (sr/kr)
nchnls = 2		; number of channels 
0dbfs = 1
instr 1

endin

</CsInstruments>
<CsScore>
e       ; end of score
</CsScore>
</CsoundSynthesizer>

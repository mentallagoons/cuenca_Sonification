Server.local.boot;  //bootear servidor local
s.boot;
thisProcess.openPorts; // abre el puerto
NetAddr.localAddr; //puerto de recepcion y dirección local
OSCFunc.trace(true); //monitoreo de mensajes activo
OSCFunc.trace(false); //monitoreo de mensajes desactivado





(
SynthDef(\tres_Datos, {
	arg freq = 40, nHarm = 10, detune = 0.5, noiseFreq = 0.4, amp = 0.7, out = 0;
	var sig, env;
	env = EnvGen.kr(Env.adsr(0.5,0.5,0.5,1), doneAction:2);
	sig = Blip.ar(freq * LFNoise1.kr(noiseFreq).bipolar(detune.neg,detune).midiratio, nHarm);
	sig = FreeVerb.ar(sig,0.5,1);
	Out.ar(out,sig!2);

}).add;
)

a = Synth.new(\tres_Datos);
a.set(\freq, 60);
a.set(\nHarm, 20);
a.set(\detune, 0.4);
a.set(\amp, 0.7);

a.free;

(
b = OSCFunc({ | msg, time, addr, port |
	var dato1, dato2, dato3, dato4;
	dato1 = msg[1]; //entre 1 y 196
	dato2 = msg[2].linlin(2008,2022,0,0.5); // entre 2008 y 2022
	dato3 = msg[3];
	dato4 = msg[4];
	("el dato 1 es" + dato1).postln;
	("el dato 2 es" + dato2).postln;
	("el dato 3 es" + dato3).postln;
	//("el dato 4 es" + dato4).postln;
	a.set(\freq,dato1);
	//a.set(\detune,dato2);
	a.set(\detune,dato3);
	a.set(\nHarm, dato4);



}, '/data');
)

b.free;

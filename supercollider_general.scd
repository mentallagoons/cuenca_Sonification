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
a.set(\freq, 40);
a.set(\nHarm, 10);
a.set(\detune, 0.5);
a.set(\amp, 0.7);

a.free;

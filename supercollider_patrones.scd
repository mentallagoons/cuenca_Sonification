Server.local.boot;  //bootear servidor local
s.boot;
thisProcess.openPorts; // abre el puerto
NetAddr.localAddr; //puerto de recepcion y dirección local
OSCFunc.trace(true); //monitoreo de mensajes activo
OSCFunc.trace(false); //monitoreo de mensajes desactivado

TempoClock.default.tempo = 120/60;

(
SynthDef.new(\sine, {
	arg freq=440, atk=0.005, rel=0.1, amp=1, pan=0;
	var sig, env;
	sig = SinOsc.ar(freq);
	env = EnvGen.kr(Env.new([0,0.5,0],[atk, rel],[1, -1]), doneAction:2);
	sig = Pan2.ar(sig, pan, amp);
	sig = sig * env;
	Out.ar(0, sig);
	}).add;

Synth.new(\sine);

Pdef(
	\texture,
	Pbind(
		\instrument, \sine,
		\dur, Pwhite(0.05, 0.5, inf),
		\midinote, Pseq([34, 58], 6),
		\harmonic, Pexprand(1, 80, inf),
		\atk, Pwhite(0.9, 3.0, inf),
		\rel, Pwhite(3.0, 7.0, inf),
		\amp, Pkey(\harmonic).reciprocal * 0.3,
//		\amp, Pexprand(0.01, 0.2, inf),
		\pan, Pwhite(-0.8, 0.8, inf),
	);
).play;


OSCdef.new(
	\texturer1,
	{
		arg msg, time, addr, port;
		var fnote = msg[1]; /// 0 - 44  midinote
		var limit = msg[2]/10; // 9.4 - 46.8  repeats seq
		var atka = msg[2]/10; // 9.4 - 46.8  repeats seq
		var harmo = msg[3]; // 42.8 - 83.3
		var vel = msg[4]/1000; // 997 - 1007
		var paner = msg[5]/10; // 30 - 75

		Pdef(\texture,
			Pbind(
				\instrument, \simplesine,
				\dur, Pwhite(0.05, 0.5, inf),
				\midinote, Pseq([fnote], limit),
				\harmonic, Pseq([harmo], inf),
				\atk, Pseq([atka], inf).trace,
				\rel, Pwhite(1.0, 2.0, inf),
				\amp, Pkey(\harmonic).reciprocal * 0.2,
				\pan, Pwhite(-0.1, paner, inf),
			);
		).play(quant:1);
	},
		'/data'
);

OSCdef.freeAll;
funcprot(0);
clear;
function bell=noteG(s, n, d) ////// BELL
//s denotes saptak (1,2,3).
// n ranges from 0 to 11
// n = 0 means Sa, 1 means Komal Re, 2 means Shuddh Re etc.
// d denotes duration. Calibrated in seconds
if s == 1
N = 2^(n/12)
elseif s == 2
N = 2*2^(n/12);
else N = 4*2^(n/12);
end
f = 130.815;
f1 = f*N;
t = 0:1/22050:d;
T = length(t);
T1 = round(0.02*T);
T2 = round(0.04*T);
T3 = round(0.88*T);
L1 = linspace(0,1,T1);
L2 = linspace(1,1,T2);
L3 = linspace(1,0.9,T2);
L4 = linspace(0.9, 0.45,T3);
L5 = linspace(0.45,0,T1);
a = [L1 L2 L3 L4 L5 ];
A = length(a);
if T > A then
diff = T-A;
for i = 1:diff
a = [a 0];
end
elseif T < A then
diff = A-T;
for i = 1:diff
t = {t 0};
end
end
if instrument == "T" then
end
//S = sin((2*%pi*f1*t + a.*sin(4*%pi*f1*t) )); //Bell
//S=2*(sin(2*%pi*f1*t)+sin(4*%pi*f1*t)/2+sin(3*%pi*f1*t)/2); //Triumph like
S=[sin(sin(2*%pi*f1*t) + a.*sin(2*%pi*f1*t) + sin(sin(8*%pi*(f1)*t)))];
bell = 2*a.*S;
endfunction
function strings=noteF(s, n, d) ///// SYNTH
//s denotes saptak (1,2,3).
// n ranges from 0 to 11
// n = 0 means Sa, 1 means Komal Re, 2 means Shuddh Re etc.
// d denotes duration. Calibrated in seconds
if s == 1
N = 2^(n/12);
elseif s == 2
N = 2*2^(n/12);
else N = 4*2^(n/12);
end
f = 130.815;
f1 = f*N;
t = 0:1/22050:d;
T = length(t);
T1 = round(0.02*T);
T2 = round(0.04*T);
T3 = round(0.88*T);
L1 = linspace(0,1,T1);
L2 = linspace(1,1,T2);
L3 = linspace(1,0.9,T2);
L4 = linspace(0.9, 0.45,T3);
L5 = linspace(0.45,0,T1);
a = [L1 L2 L3 L4 L5 ];
A = length(a);
if T > A then
diff = T-A;
for i = 1:diff
a = [a 0];
end
elseif T < A then
diff = A-T;
for i = 1:diff
t = {t 0};
end
end
//S1 = sin((2*%pi*f1*t + a.*sin(4*%pi*f1*t) ));
S1=sin(2*%pi*f1*t)+sin(4*%pi*f1*t)/2+sin(3*%pi*f1*t)/2; //SYNTH
strings = 10*a.*S1;
endfunction
function COMPOSITION=composed(instrument, d1, Scale)
d0 = (d1)/2;
d2 = 2*d1;
d3 = d1*(3/2);
d4 = 4*d1;
inter=0*[0:1/22050:d1];
if Scale == "C" then
scale=[ 0,2,4,5,7,9,11,12];
elseif Scale == "D" then
scale=[2,4,6,7,9,11,13,14];
elseif Scale == "E" then
scale=[4,6,8,9,11,13,15,16];
elseif Scale == "Dm" then
scale=[2,4,5,7,9,10,12,14]
end
if instrument == "s" then
temp=[];
for j = 1:2
for i = 0:3
y = grand(1,"uin",1,8);
random = noteF(2,scale(y),d1);
composition = [temp random];
temp = composition;
end
for i = 0:1
Y = grand(1,"uin",4,8);
random = noteF(1,scale(Y),d2);
composition = [temp random];
temp = composition;
end
end
temp2=[];
for j = 1:1
for i = 0:3
Y1 = grand(1,"uin",1,8);
random2 = noteF(2,scale(Y1),d1);
composition2 = [temp2 random2];
temp2 = composition2;
end
final = [inter temp2 ];
temp2 = final;
end
num = grand(1,"uin",1,8);
ran = noteF(2,scale(num),d4)
melody1 = [composition composition ];
melody2 = [composition2 composition2 ran ];
music = [melody1 melody2 melody1];
elseif instrument == "b" then
temp=[];
for j = 1:2
for i = 0:3
y = grand(1,"uin",1,8);
random = noteG(2,scale(y),d1);
composition = [temp random];
temp = composition;
end
for i = 0:1
Y = grand(1,"uin",4,8);
random = noteG(1,scale(Y),d2);
composition = [temp random];
temp = composition;
end
end
temp2=[];
for j = 1:1
for i = 0:3
Y1 = grand(1,"uin",1,8);
random2 = noteG(2,scale(Y1),d1);
composition2 = [temp2 random2];
temp2 = composition2;
end
final = [ temp2 random2];
temp2 = final;
end
num = grand(1,"uin",1,8);
ran = noteG(2,scale(num),d4)
melody1 = [composition composition ];
melody2 = [composition2 composition2 ran ];
music = [melody1 melody2 melody1 ];
end
COMPOSITION = music;
endfunction
////// MAIN FUNCTION///////
printf("Select the Type of Melody\n" + "1.Happy\n" + "2.Sad\n" + "3.Customized\n");
//int x;
genre = input("","string");
if genre == "1" then
x = 180;
Scale = "C"
elseif genre == "2" then
x = 120;
Scale = "Dm"
elseif genre == "3" then
x=input("Enter the desired Tempo: - ");
Scale = input("Enter the desired Scale: - ","string");
end
d1 =60/x; /// Tempo
printf("\n");
printf("Select any Instrument\n" + "->Press ''s'' for strings\n" + "->Press ''b'' forbell\n");
Instrument = input("","string");
FINAL = composed(Instrument,d1,Scale)
printf("Save the file as\n");
name = input("","string");
wavwrite(FINAL,name);
printf("\n");
printf("##The Automatic music is generated and saved to a File##");
//sound(FINAL);

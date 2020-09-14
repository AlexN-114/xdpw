{ Calculate 20000 numbers of PI in Pascal }

program Pi;
const
  f = 20000;
  e = f*4;
  line_lng = 100;
var
  stream : file;
  r : array[0..e+1] of integer;
  p : array[0..f+1] of integer;
  l,i,j,z,a,b,s : integer;
  StartTime, StopTime: LongInt;


begin
  WriteLn('Begin of calculating Pi');

  StartTime := GetTickCount;

  for l:=0 to e do
    r[l] := 2;

  for l:=0 to f do
    p[l] := 0;

  {Start calc}
  for j:=1 to f do
  begin
    s:=0;
    i:=e;
    while i>=2 do
    begin
      a:=i-1;
      b:=a*2+1;

      z:=r[i]*10+s;
      s:=(z div b)*a;
      r[i]:=z mod b;
      // WriteLn('i  ',i,' ',a,' ',b,' ',z,' ',s,' ',r[i]);
      dec(i);
    end;

    z:=r[i]*10+s;
    p[j]:=z div 10;
    r[1]:=z mod 10;
    // WriteLn('j  ',j,' ',z,' ',p[j],' ',r[1]);

    {Digit correction}
    i:=j;
    while p[i]>9 do
    begin
      p[i]:=p[i]-10;
      dec(i);
      p[i]:=p[i]+1;
    end;

    if j mod 1000 = 0 then
      WriteLn('Got ', j, ' digits of Pi');
  end;

  StopTime := GetTickCount;

  WriteLn(chr(10),'End of calculating Pi after ', (StopTime - StartTime)/1000 :8:3,' s');

  {Output}
  Assign(stream, 'Pascal_Pi.txt');
  Rewrite(stream);

  j:=0;
  for j:=0 to (f div line_lng)-1 do
  begin
    for i:=1 to line_lng do
    begin
      Write(stream,p[j*line_lng+i]);
      //Write(p[j*line_lng+i]);
    end;
    WriteLn(stream,'');
  end;
  Close(stream);

  WriteLn(chr(10),'Printed Pi to Pascal_Pi.txt');

end.

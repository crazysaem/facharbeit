unit Unit1;
                                                                                     
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdDraws, AdClasses, AdTypes, AdPNG, AdCanvas, IniFiles, math;

procedure drawscene;
function form1move():boolean;
procedure dockforms;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    AdDraw:TAdDraw;
    //AdPerCounter:TAdPerformanceCounter;
    AdImageList:TAdImageList;
    procedure Idle(Sender:TObject;var Done:boolean);
    //procedure SetLine;
    { Public-Deklarationen }
  end;

type
  KomplexeZahl = record
  x,y:extended;
  end;

var
  Form1: TForm1;
  mdown,firststart:boolean;
  mx,my,f1left,f1top,lin,xe,xa,ye,ya:integer;
  xmin,xmax,ymin,ymax:extended;
  Fstring:string;

implementation

uses Unit2, Unit3;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var ini: TIniFile;
    f1l,f1t:integer;
    v2:boolean;
begin

  xmin:=2147483647;
  xmax:=-2147483647;
  ymin:=2147483647;
  ymax:=-2147483647;
  lin:=3;

  firststart:=true;

  ini:=TIniFile.create(ExtractFilePath(ParamStr(0))+'settings.ini');

  //breite:=ini.ReadInteger('Settings','Breite',700);
  //hoehe:=ini.ReadInteger('Settings','Hoehe',500);

  v2:=ini.ReadBool('Settings','Firstrun',false);

  if v2=false then begin showmessage( 'Dieses Programm wurde zum ersten Mal gestartet.'+#10+#13+
                                      'Bitte lesen sie "Readme.txt" für eine Beschreibung des Programmes.');

    form1.Top:=10;
    form1.Left:=230;

    ini.WriteBool('Settings','Firstrun',true);
  end else begin
    f1l:=ini.ReadInteger('Settings','F1left',230);
    f1t:=ini.ReadInteger('Settings','F1top',10);
    form1.Left:=f1l;
    form1.Top:=f1t;
  end;

  //showmessage('Breite: '+inttostr(breite)+'Höhe'+inttostr(hoehe));

  //form1.Width:=breite;
  //form1.Height:=hoehe;

  ini.Free;

  //Andorra Initialisierung

  AdDraw := TAdDraw.Create(self);
  AdDraw.DllName := 'AndorraDX93D.dll';

  if AdDraw.Initialize then
    begin
      Application.OnIdle := Idle;
    end
  else
    begin
      ShowMessage(AdDraw.GetLastError);
      halt; //<-- Schließt die komplette Anwendung
    end;

  AdImageList := TAdImageList.Create(AdDraw);

  AdDraw.Canvas.Pen.Color:=Ad_ARGB(255, 0, 0, 0);
  AdDraw.Canvas.Pen.Width:=2;

  //Benötigte Bilder werden Geladen:
  {
  with AdImageList.Add('koordsys') do //Zu der Liste wird ein Bild mit dem Namen "koordsys" hinzugefügt.
  begin
    Texture.LoadGraphicFromFile('Data\koordsys.png',true,clFuchsia); //In die Textur wird ein Bild hineingeladen.
  end;
  AdImageList.Restore;}

end;

function sqrZ(Z:KomplexeZahl):KomplexeZahl;
begin
    sqrZ.x:=sqr(z.x)-sqr(z.y);
    sqrZ.y:=2*z.x*z.y
end;

function ZmalZ(Z1,Z2:KomplexeZahl):KomplexeZahl;
begin
    ZmalZ.x:=Z1.x*Z2.x-Z1.y*Z2.y;
    ZmalZ.y:=z1.x*z2.y+Z2.x*Z1.y;
end;

function ZFunction(x,y:extended):KomplexeZahl;
var zrueck:extended;
    Z,Ztemp:KomplexeZahl;
    hoch,lauf:integer;
    hochstr:string;
begin
  //z:=y;
  //zrueck:=sqr(x)-sqr(y);

  Z.x:=x;
  Z.y:=y;

  Ztemp.x:=x;
  Ztemp.y:=y;

  if pos('^',Fstring)<>0 then begin
    hochstr:=copy(Fstring,pos('^',Fstring)+2,length(Fstring));
    hochstr:=copy(hochstr,0,pos(')',hochstr)-1);
    hoch:=strtoint(hochstr);
    if hoch>1 then begin
      Z:=sqrZ(Z);
      hoch:=hoch-2;
      if hoch>=0 then begin
        for lauf:=1 to hoch do begin
          //Z:=sqrZ(Z);
          Z:=ZmalZ(Z,Ztemp);
          application.ProcessMessages;
        end;
      end;
    end;
  end;

  //zrueck:=z.x;

  ZFunction.x:=z.x;
  ZFunction.y:=z.y;

  //ZFunction:=zrueck;//-1+zrueck*2; //-1 + Z*2 , -1; *2 Dient als Ausgleich für die Pos. des Würfels.
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  AdDraw.Free;
end;

function form1move():boolean;
begin

if (f1left <> form1.Left) or (f1top <> form1.Top) then begin
f1left:=form1.Left;
f1top:=form1.Top;
form1move:=true;
end else begin
form1move:=false;
end;

end;

procedure dockforms;
begin

  if (form1move and form3.CheckBox1.Checked) or firststart then begin

  form2.Left:=form1.Left-215;
  form2.Top:=form1.Top;

  form3.Left:=form1.Left-220;
  form3.Top:=form1.Top+230;

  firststart:=false;

  end;

end;

procedure Koord(x1,y1,w,h:integer;xa,xe,ya,ye:extended);
var x0,y0,lauf,lauf2,abst,wtich,omg:integer;
begin

  x0:=trunc(w/(xe-xa)*xe)*-1+x1+w;
  y0:=trunc(h/(ya-ye)*ya)+y1;

  if xa>=0 then x0:=x1;
  if xe<=0 then x0:=x1+w;

  if ye>=0 then y0:=y1+h;
  if ya<=0 then y0:=y1;

  with form1.AdDraw.Canvas do begin

  Pen.Color:=Ad_ARGB(255, 0, 0, 0);
  pen.Width:=2;

  moveto(x0,y1);
  lineto(x0,y1+h);

  textout(x0+7,y1+5,'Im');

  moveto(x1,y0);
  lineto(x1+w,y0);

  textout(x1+w-7,y0-23,'Re');

  lauf:=x0;
  lauf2:=0;

  //if ((x1+w)-x0)>=35 then abs:=trunc(((x1+w)-x0)/10);

  if ((x1+w)-x0)>(x0-x1) then begin abst:=trunc(((x1+w)-x0)/10);wtich:=1 end else begin abst:=trunc((x0-x1)/10);wtich:=2; end;

  omg:=(((x1+w)-x0)-(x0-x1));
  omg:=abs(omg);

  if omg<=35 then wtich:=-1;

    while not (lauf>=(x1+w-abst/5)) do begin

      Pen.Color:=Ad_ARGB(255, 0, 0, 0);
      pen.Width:=2;

      lauf:=lauf+abst;
      lauf2:=lauf2+1;

      if (wtich=1) or (wtich=-1) then begin

        if lauf2=5 then begin textout(lauf-8,y0+7,floattostrF(xe/2 , ffFixed, 4, 1) ); pen.Width:=3; end;
        if lauf2=10 then begin textout(lauf-8,y0+7,floattostrF(xe , ffFixed, 4, 1) ); pen.Width:=3; end;

       end else begin
        if lauf>=(x1+w-abst) then begin textout(lauf-8,y0+7,floattostrF(xe , ffFixed, 4, 1) ); pen.Width:=3; end;
       end;

      moveto(lauf,y0-5);
      lineto(lauf,y0+5);

       Pen.Color:=Ad_ARGB(30, 0, 0, 0);
       pen.Width:=1;

      moveto(lauf,y1);
      lineto(lauf,y1+h);

    end;


  lauf:=x0;
  lauf2:=0;

  //if (x0-x1)>=35 then abs:=trunc((x0-x1)/10);

    while not (lauf<=(x1+abst/5)) do begin

       Pen.Color:=Ad_ARGB(255, 0, 0, 0);
       pen.Width:=2;

      lauf:=lauf-abst;
      lauf2:=lauf2+1;

      if (wtich=2) or (wtich=-1) then begin

      if lauf2=5 then begin textout(lauf-12,y0+7,floattostrF(xa/2 , ffFixed, 4, 1) ); pen.Width:=3; end;
      if lauf2=10 then begin textout(lauf-12,y0+7,floattostrF(xa , ffFixed, 4, 1) ); pen.Width:=3; end;

      end else begin

      if lauf<=x1 then begin textout(lauf-12,y0+7,floattostrF(xa , ffFixed, 4, 1) ); pen.Width:=3; end;

      end;

      moveto(lauf,y0-5);
      lineto(lauf,y0+5);

       Pen.Color:=Ad_ARGB(30, 0, 0, 0);
       pen.Width:=1;

      moveto(lauf,y1);
      lineto(lauf,y1+h);

    end;

    lauf:=y0;
    lauf2:=0;

    if ((y1+h)-y0)>(y0-y1) then abst:=trunc(((y1+h)-y0)/10) else abst:=trunc((y0-y1)/10);

    while not (lauf>=(y1+h+abst/5)) do begin

       Pen.Color:=Ad_ARGB(255, 0, 0, 0);
       pen.Width:=2;

      lauf:=lauf+abst;
      lauf2:=lauf2+1;

      if lauf2=5 then begin textout(x0-30,lauf-9, floattostrF(ye/2 , ffFixed, 4, 1) ); pen.Width:=3; end;
      if lauf2=10 then begin textout(x0-30,lauf-9, floattostrF(ye , ffFixed, 4, 1) ); pen.Width:=3; end;

      moveto(x0-5,lauf);
      lineto(x0+5,lauf);

       Pen.Color:=Ad_ARGB(30, 0, 0, 0);
       pen.Width:=1;

       moveto(x1,lauf);
      lineto(x1+w,lauf);

    end;

    lauf:=y0;
    lauf2:=0;

    while not (lauf<=(y1-abst/5)) do begin

       Pen.Color:=Ad_ARGB(255, 0, 0, 0);
       pen.Width:=2;

      lauf:=lauf-abst;
      lauf2:=lauf2+1;

      if lauf2=5 then begin textout(x0-30,lauf-9, floattostrF(ya/2 , ffFixed, 4, 1) ); pen.Width:=3; end;
      if lauf2=10 then begin textout(x0-30,lauf-9, floattostrF(ya , ffFixed, 4, 1) ); pen.Width:=3; end;

      moveto(x0-5,lauf);
      lineto(x0+5,lauf);

       Pen.Color:=Ad_ARGB(30, 0, 0, 0);
       pen.Width:=1;

       moveto(x1,lauf);
      lineto(x1+w,lauf);

    end;

  pen.Width:=1;

  end;

end;

procedure gmuster(lines:integer); overload;
var xlauf,x,y,ylauf:integer;
begin
 with form1.AdDraw.Canvas do begin
  pen.Color:=Ad_RGB(255,0,0);

  xlauf:=0;
    repeat
    x:=15+trunc(300*(xlauf/lines));
      for ylauf:=15 to 515 do begin
        PlotPixel(x,ylauf);
      end;
    xlauf:=xlauf+1;
    until xlauf>lines;

 ylauf:=0;
    repeat
    y:=15+trunc(500*(ylauf/lines));
      for xlauf:=15 to 315 do begin
        PlotPixel(xlauf,y);
      end;
    ylauf:=ylauf+1;
    until ylauf>lines;
 end;

end;

function komplexefunktion(Z:KomplexeZahl):KomplexeZahl;
var z2,z3:KomplexeZahl;
    x0,y0:integer;
    l,l2:extended;
begin

  //x0:=trunc(300/2)+345;
  //y0:=trunc(500/2)+15;

  //z.x:=(z.x-x0)/10;
  //z.y:=(z.y-y0)/10*-1;

  x0:=345;
  y0:=15;

  z.x:=(z.x-x0)/10;
  z.y:=(z.y-y0)/10;
  //z.y:=25-z.y;

  //if z.x>0 then z.x:=z.x*(abs(xe)/15) else z.x:=z.x*(abs(xa)/15);
  //if z.y>0 then z.y:=z.y*(abs(ye)/25) else z.y:=z.y*(abs(ya)/25);

  l:=30/(xe-xa);
  l2:=50/(ye-ya);

  //z3.x:=xa+(z.x/l)*(xe-xa);
  //z3.y:=ya+(z.y/l2)*(ye-ya);

  z3.x:=xa+(z.x/l);
  z3.y:=ya+(z.y/l2);

  //z.x:=z.x*-1;
  //z.y:=z.y*-1;

  z2:=ZFunction(z3.x,z3.y);

  //z2.x:=sqr(z.x)-sqr(z.y);
  //z2.y:=2*z.x*z.y;

  komplexefunktion.x:=z2.x;
  komplexefunktion.y:=z2.y;
end;

procedure gmuster(lines:integer;asdf:string); overload;
var xlauf,x,y,ylauf,drawx,drawy:integer;
    xlength,ylength:extended;
    z2,z1:KomplexeZahl;
    switch:boolean;
begin

  if asdf='0' then begin

  z1.x:=345;z1.y:=15;
  z2:=komplexefunktion(z1);

  xmin:=z2.x;
  xmax:=z2.x;
  ymin:=z2.y;
  ymax:=z2.y;

    xlauf:=0;
    repeat
    x:=345+trunc(300*(xlauf/lines));
      for ylauf:=15 to 515 do begin
        z1.x:=x;z1.y:=ylauf;
        z2:=komplexefunktion(z1);
        if z2.x<xmin then xmin:=z2.x;
        if z2.x>xmax then xmax:=z2.x;
        if z2.y<ymin then ymin:=z2.y;
        if z2.y>ymax then ymax:=z2.y;
      end;
    xlauf:=xlauf+1;
    until xlauf>lines;

 ylauf:=0;
    repeat
    y:=15+trunc(500*(ylauf/lines));
      for xlauf:=345 to 645 do begin
        z1.x:=xlauf;z1.y:=y;
        z2:=komplexefunktion(z1);
        if z2.x<xmin then xmin:=z2.x;
        if z2.x>xmax then xmax:=z2.x;
        if z2.y<ymin then ymin:=z2.y;
        if z2.y>ymax then ymax:=z2.y;
      end;
    ylauf:=ylauf+1;
    until ylauf>lines;
  end;

  if asdf='1' then begin

  xlength:=xmax-xmin;
  ylength:=ymax-ymin;

 with form1.AdDraw.Canvas do begin
  pen.Color:=Ad_RGB(255,0,0);

  switch:=false;
  xlauf:=0;
    repeat
    x:=345+trunc(300*(xlauf/lines));
      for ylauf:=15 to 515 do begin
        z1.x:=x;z1.y:=ylauf;
        z2:=komplexefunktion(z1);
        drawx:=trunc(345 + (300/xlength)*(z2.x-xmin));
        drawy:=trunc(515 - (500/ylength)*(z2.y-ymin));
        //PlotPixel(drawx,drawy);
        if switch=false then begin
          moveto(drawx,drawy);
          switch:=true;
        end else begin
          lineto(drawx,drawy);
          moveto(drawx,drawy);
          //switch:=false;
        end;
      end;
    xlauf:=xlauf+1;
    switch:=false;
    until xlauf>lines;

    switch:=false;

 ylauf:=0;
    repeat
    y:=15+trunc(500*(ylauf/lines));
      for xlauf:=345 to 645 do begin
        z1.x:=xlauf;z1.y:=y;
        z2:=komplexefunktion(z1);
        drawx:=trunc(345 + (300/xlength)*(z2.x-xmin));
        drawy:=trunc(515 - (500/ylength)*(z2.y-ymin));
        //showmessage(inttostr(yylauf));
        //PlotPixel(drawx,drawy);
        if switch=false then begin
          moveto(drawx,drawy);
          switch:=true;
        end else begin
          lineto(drawx,drawy);
          moveto(drawx,drawy);
          //switch:=false;
        end;
      end;
    ylauf:=ylauf+1;
    switch:=false;
    until ylauf>lines;
 end;

 end;

end;

procedure drawscene;
var x0,y0,e1,e2,lauf:integer;
begin

 with form1.AdDraw.Canvas do
    begin

      Koord(15,15,300,500,xa,xe,ye,ya);

      gmuster(lin);
      gmuster(lin,'0');

      Koord(345,15,300,500,trunc(xmin),trunc(xmax),trunc(ymax),trunc(ymin));


      gmuster(lin,'1');

        //Rectangle(x0+e1-2,y0-e2+2,x0+strtoint(form2.edit1.text),y0-strtoint(form2.edit2.text));

        Pen.Color:=Ad_ARGB(255,255,0,0);

        Brush.Color :=Ad_ARGB(255,255,0,0);

        Pen.Color:=Ad_ARGB(255, 0, 0, 200);
        {
        if form3.CheckBox2.Checked=true then begin

          moveto(x0+e1*10,y0);
          lineto(x0+e1*10,y0-e2*10);

          moveto(x0,y0-e2*10);
          lineto(x0+e1*10,y0-e2*10);

          Pen.Color:=Ad_ARGB(255, 0, 255, 0);

          moveto(x0,y0);
          lineto(x0+e1*10,y0-e2*10);

          Pen.Color:=Ad_ARGB(255, 0, 0, 0);

          //Textout(x0+e1*10+5,y0-e2*10,'P('+form2.Edit1.Text+';'+form2.Edit2.Text+')');

        end;}

        Pen.Color:=Ad_ARGB(255,255,0,0);

        //Circle(x0+e1*10,y0-e2*10,2);

        Pen.Color:=Ad_ARGB(255, 0, 0, 0);

      Release; //<-- Lässt man diese Zeile weg, wird nichts gezeichnet

      end;

      sleep(1);
end;

procedure TForm1.Idle(Sender: TObject; var Done: boolean);
begin
  //dockforms;
  {
  if AdDraw.CanDraw then //Wenn überhaupt auf das AdDraw gezeichnet werden kann dann...
  begin

    AdDraw.ClearSurface(clWhite); //Füllt die Oberfläche mit schwarzer Farbe

    AdDraw.BeginScene;
    //Zwischen diesen beiden Zeilen müssen später unsere Zeichenfunktionen stehen

    //AdImageList.Find('koordsys').StretchDraw(AdDraw,AdRect(0,0,form1.Width,form1.Height),0);

    //drawscene;

    dockforms;

    AdDraw.EndScene;

    AdDraw.Flip; //Präsentiert die gezeichneten Dinge auf dem Bildschirm.

  end;}

  //sleep(25);
  //Done := false; // Diese Zeile nicht vergessen, sonst wird der Code nur sporadisch ausgeführt.

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var ini: TIniFile;
begin
  ini:=TIniFile.create(ExtractFilePath(ParamStr(0))+'settings.ini');
  
  ini.WriteBool('Settings','F3visible',form3.Visible);

  ini.WriteInteger('Settings','F1left',form1.Left);
  ini.WriteInteger('Settings','F1top',form1.top);

  ini.Free
end;

end.

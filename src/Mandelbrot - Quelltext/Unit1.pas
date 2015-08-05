unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdDraws, AdClasses, AdTypes, AdPNG, AdCanvas, IniFiles;

procedure drawmandelbrot(xmin,xmax,ymin,ymax:extended);
procedure zoom(mx,my,mx2,my2:integer);
procedure dockforms;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    AdDraw:TAdDraw;
    AdTextureSurface:TAdTextureSurface;
    AQuad:TAdCanvasColorQuad;
    procedure Idle(Sender:TObject; var Done:boolean);
  end;

type
  TMYcolor = record
  red,green,blue:byte;
  end;

var
  Form1: TForm1;
  MYcolor:TMYcolor;
  mdown,mandel,pstart,firststart,mandstart:boolean;
  mx,my,mx2,my2,iter,f1left,f1top,colorset,tool:integer;
  xa,xe,ya,ye:extended;
  dllname:string;


implementation

uses Unit2, Unit3;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var ini: TIniFile;
    breite,hoehe,f1l,f1t:integer;
    firstrun:boolean;
begin

  pstart:=true;
  mandstart:=true;

  ini:=TIniFile.create(ExtractFilePath(ParamStr(0))+'settings.ini');

  breite:=ini.ReadInteger('Settings','Breite',900);
  hoehe:=ini.ReadInteger('Settings','Hoehe',600);

  form1.ClientWidth:=breite;
  form1.ClientHeight:=hoehe;

  firstrun:=ini.ReadBool('Settings','Firstrun',false);

  f1l:=ini.ReadInteger('Settings','F1left',250);
  f1t:=ini.ReadInteger('Settings','F1top',10);

  dllname:=ini.ReadString('Settings','DllName','AndorraOGL.dll');

  colorset:=ini.ReadInteger('Settings','Colorset',0);

  if firstrun then begin
    showmessage(  'Dieses Programm wurde zum ersten Mal gestartet.'+#10+#13+
                  'Bitte lesen sie "Readme.txt" für eine Beschreibung des Programmes.');
    ini.WriteBool('Settings','Firstrun',false);
  end;

  ini.free;

  form1.Left:=f1l;
  form1.Top:=f1t;

  f1left:=form1.Left;
  f1top:=form1.Top;

  //-------

  AdDraw := TAdDraw.Create(self);
  //AdDraw.DllName := 'AndorraDX93D.dll';
  AdDraw.DllName := dllname;

  if AdDraw.Initialize then
    begin
      Application.OnIdle := Idle;
    end
  else
    begin
      ShowMessage(AdDraw.GetLastError);
      halt; //<-- Schließt die komplette Anwendung
    end;
  
  mandel:=true;
  mdown:=false;

  xa:=-2;
  xe:=1;
  ya:=1;
  ye:=-1;

  AdTextureSurface:=TAdTextureSurface.Create(AdDraw);
  AdTextureSurface.SetSize(form1.ClientWidth,form1.ClientHeight);
  adTextureSurface.ClearSurface(0);

  firststart:=false;

  //colorset:=1;
  //tool:=1;

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

  if (form1move=true and form3.CheckBox1.Checked=true) or pstart=true then begin

  if form3.CheckBox1.Checked=false then begin if pstart=false then exit; end;

  form2.Left:=form1.Left-215;
  form2.Top:=form1.Top;

  form3.Left:=form1.Left-215;
  form3.Top:=form1.Top+192;

  pstart:=false;

  end;

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  AdDraw.Free;
  AdTextureSurface.Free;
end;

function mandelbrot(incx,incy:extended):integer;
var lauf:integer;
    cx,cy,xZ,yZ,real,imag,part1,part2,part3:extended;
begin

  lauf:=0;                                                                                                                                                                                       

  //x:=incx;
  //y:=incy;
  {
  xz:=incx;
  yz:=incy;}
  xz:=0;
  yz:=0;

  cx:=incx;
  cy:=incy;

  repeat

  //Zn+1 = Zn² + c

  //Zn² = (x+y*i)² = x² + 2*xyi -y² = part1 + part2 + part3

  {
  part1:=sqr(xz);
  part2:=2*xz*yz;
  part3:=sqr(yz)*-1;

  real:=part1+part3+cx;
  imag:=part2+cy;

  xz:=real;
  yz:=imag;}

  real:=sqr(xz)-sqr(yz)+cx;
  imag:=2*xz*yz+cy;

  xz:=real;
  yz:=imag;

  lauf:=lauf+1;

  until (sqrt( sqr(xz)+sqr(yz) ) > 2) or (lauf>iter);

  mandelbrot:=lauf;

end;

function mandelcolor(lauf,laufmax:integer):TMYcolor;
var multi:extended;
    clauf:integer;
begin

if colorset=0 then begin
  multi:=(1536/laufmax);     //RGB(r,g,b) bietet 1536 mögliche Farben
  clauf:=trunc(lauf*multi); //clauf<256 RGB(255,0,clauf); clauf<512 RGB(clauf-256,0,255);  clauf<768 RGB(0,767-clauf,255)
                             //clauf<1023 RGB(0,255,clauf-767) ; clauf<1280 RGB(1279-clauf,255,0); clauf<1535 RGB(255,clauf-1279,0)
                             //clauf>=1536 RGB(255,0,0)
  if clauf<256 then begin mandelcolor.red:=255;mandelcolor.green:=0;mandelcolor.blue:=clauf;exit; end;
  if clauf<512 then begin mandelcolor.red:=clauf-256;mandelcolor.green:=0;mandelcolor.blue:=255;exit; end;
  if clauf<768 then begin mandelcolor.red:=0;mandelcolor.green:=767-clauf;mandelcolor.blue:=255;exit; end;
  if clauf<1023 then begin mandelcolor.red:=0;mandelcolor.green:=255;mandelcolor.blue:=clauf-767;exit; end;
  if clauf<1280 then begin mandelcolor.red:=1279-clauf;mandelcolor.green:=255;mandelcolor.blue:=0;exit; end;
  if clauf<1535 then begin mandelcolor.red:=255;mandelcolor.green:=clauf-1279;mandelcolor.blue:=0;exit; end;
  if lauf>=laufmax then begin
  mandelcolor.red:=0;mandelcolor.green:=0;mandelcolor.blue:=0;
  end else begin
  mandelcolor.red:=255;mandelcolor.green:=0;mandelcolor.blue:=0;
  end;
  exit;
end;


if colorset=1 then begin
  clauf:=255-trunc(255/laufmax)*lauf;
  if lauf>=laufmax then begin mandelcolor.red:=0;mandelcolor.green:=0;mandelcolor.blue:=0;exit; end;
  mandelcolor.red:=clauf;mandelcolor.green:=clauf;mandelcolor.blue:=clauf;exit
end;

if colorset=2 then begin
  clauf:=255-trunc(255/laufmax)*lauf;
  if lauf>=laufmax then begin mandelcolor.red:=0;mandelcolor.green:=0;mandelcolor.blue:=0;exit; end;
  mandelcolor.red:=clauf;mandelcolor.green:=0;mandelcolor.blue:=0;exit
end;

if colorset=3 then begin
  clauf:=255-trunc(255/laufmax)*lauf;
  if lauf>=laufmax then begin mandelcolor.red:=0;mandelcolor.green:=0;mandelcolor.blue:=0;exit; end;
  mandelcolor.red:=0;mandelcolor.green:=clauf;mandelcolor.blue:=0;exit
end;

if colorset=4 then begin
  clauf:=255-trunc(255/laufmax)*lauf;
  if lauf>=laufmax then begin mandelcolor.red:=0;mandelcolor.green:=0;mandelcolor.blue:=0;exit; end;
  mandelcolor.red:=0;mandelcolor.green:=0;mandelcolor.blue:=clauf;exit
end;

end;

procedure drawmandelbrot(xmin,xmax,ymin,ymax:extended);
var x,y:integer;
    incx,incy:extended;
    mcolor:Tmycolor;
begin



  //form1.AdDraw.BeginScene;

  //form1.AdDraw.ClearSurface(clWhite);



  form1.AdTextureSurface.ClearSurface(clWhite);

  //with form1.AdDraw.Canvas do
  with form1.AdTextureSurface.Canvas do
    begin

      pen.Color:=Ad_ARGB(255, 0, 0, 0);
      pen.Width:=1;
      //PlotPixel(20,20);

      //moveto(0,0);
      //lineto(20,20);


      for x:=0 to form1.ClientWidth do begin
        for y:=0 to form1.ClientHeight do begin
          //incx:=-2+(x/300);
          //incy:=1-(y/300);
          //incx:=xmin+(abs(xmin)+abs(xmax))*(x/form1.ClientWidth);
          //incy:=ymax-(abs(ymin)+abs(ymax))*(y/form1.ClientHeight);
          //incx:=xmin+(abs(xmax)+abs(xmin))*(x/form1.ClientWidth);
          //incy:=ymax-(abs(ymin)+abs(ymax))*(y/form1.ClientHeight);
          incx:=xmin+(xmax-xmin)*(x/form1.ClientWidth);
          //incy:=ymax-(abs(ymin)+abs(ymax))*(y/form1.ClientHeight);
          incy:=ymax-(ymax-ymin)*(y/form1.ClientHeight);
          //if mandelbrot(incx,incy)>=100 then PlotPixel(x,y);
          mcolor:=mandelcolor(mandelbrot(incx,incy),iter);
          pen.Color:=Ad_RGB(mcolor.red,mcolor.green,mcolor.blue);
          PlotPixel(x,y);
          application.ProcessMessages;
        end;
        if x=344 then begin
          //release;
          //exit;
          application.ProcessMessages;
        end;
      end;
      
      Release; //<-- Lässt man diese Zeile weg, wird nichts gezeichnet

      end;
      
      mandel:=true;

      //if firststart=false then begin
      //form2.Button1.Visible:=true;
      //form2.Label5.Visible:=false;
      //end;

  //form1.AdDraw.EndScene;
end;

procedure verschieben(mx,my,mx2,my2:integer);
var xver,yver:integer;
begin

xver:=(mx-mx2);
yver:=(my-my2);

zoom(0+xver,0+yver,form1.ClientWidth+xver,form1.ClientHeight+yver);

end;

procedure zoom(mx,my,mx2,my2:integer);
var my2real,my2realback,xmin,xmax,ymin,ymax,mxback:extended;
begin
      if my2>my then begin
      my2real:=((abs(mx2-mx)/3)+(my/2))*2;
      end else begin
      my2real:=((abs(mx2-mx)/3)-(my/2))*-2;
      end;

      if mx2<mx then begin
      mxback:=mx;
      mx:=mx2;
      mx2:=trunc(mxback);
      end;

      //min:=xa+(mx/form1.ClientWidth)*(abs(xa)+abs(xe));
      //xmax:=xa+(mx2/form1.ClientWidth)*(abs(xa)+abs(xe));

      xmin:=xa+(mx/form1.ClientWidth)*abs(xe-xa);
      xmax:=xa+(mx2/form1.ClientWidth)*abs(xe-xa);


      if my2real<my then begin
      my2realback:=my2real;
      my2real:=my;
      my:=trunc(my2realback);
      end;

      //ymax:=ya-(my/form1.ClientHeight)*(abs(ya)+abs(ye));
      //ymin:=ya-(my2real/form1.ClientHeight)*(abs(ya)+abs(ye));

      ymax:=ya-(my/form1.ClientHeight)*abs(ye-ya);
      ymin:=ya-(my2real/form1.ClientHeight)*abs(ye-ya);

      xa:=xmin; //-2
      xe:=xmax; //1

      ye:=ymin; //-1
      ya:=ymax; //1

      //showmessage('xmin: '+floattostr(xmin)+' xmax: '+floattostr(xmax)+' ymin: '+floattostr(ymin)+' ymax: '+floattostr(ymax));
    
      drawmandelbrot(xmin,xmax,ymin,ymax);
end;

procedure TForm1.Idle(Sender: TObject; var Done: boolean);
begin
  if AdDraw.CanDraw then //Wenn überhaupt auf das AdDraw gezeichnet werden kann dann...
  begin
    AdDraw.ClearSurface(clWhite); //Füllt die Oberfläche mit schwarzer Farbe

    AdDraw.BeginScene;

    //dockforms;

      //drawmandelbrot;
      //AdDraw.Canvas:=form1.canvas;

    if (mdown=true) and (tool=0) then begin
      with AdDraw.Canvas do begin
      pen.Width:=1;
      pen.Color:=ad_rgb(0,255,0);
      brush.Style:=abClear;
      //(abs(my2-my)/2)=(abs(mx2-mx)/3)
      if my2>my then begin
      Rectangle(mx,my,mx2,trunc(((abs(mx2-mx)/3)+(my/2))*2));
      end else begin
      Rectangle(mx,my,mx2,trunc(((abs(mx2-mx)/3)-(my/2))*-2));
      end;

      end;
    end;

    if (tool=1) and (mdown=true) then begin
      AdTextureSurface.Image.Draw(AdDraw,(mx-mx2)*-1,(my-my2)*-1,0);
    end else begin
      AdTextureSurface.Image.Draw(AdDraw,0,0,0);
    end;

    AdDraw.EndScene;

    AdDraw.Flip; //Präsentiert die gezeichneten Dinge auf dem Bildschirm.
  end;
 
  Done := false; // Diese Zeile nicht vergessen, sonst wird der Code nur sporadisch ausgeführt.
  Sleep(1);
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then begin
    mdown:=true;
    mx:=x;
    my:=y;
    mx2:=x;
    my2:=y;
    //showmessage('X: '+inttostr(x)+' Y: '+inttostr(y));
  end;
end;

procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  if abs(mx-mx2)<2 then begin
  mx:=0;my:=0;mx2:=0;my2:=0;
  mdown:=false;
  exit;
  end;

  if Button = mbLeft then begin
    mdown:=false;
    if tool=0 then begin

    AdDraw.BeginScene;
      AdDraw.Canvas.Pen.Color:=ad_argb(255,0,0,0);
      Addraw.Canvas.TextOut(0,0,'Bitte warten, Fraktal wird geladen');
    AdDraw.EndScene;
    AdDraw.Flip;

    zoom(mx,my,mx2,my2);
    end;
    if tool=1 then begin
    //zoom(mx,my,mx2,my2);

    AdDraw.BeginScene;
      AdDraw.Canvas.Pen.Color:=ad_argb(255,0,0,0);
      Addraw.Canvas.TextOut(0,0,'Bitte warten, Fraktal wird geladen');
    AdDraw.EndScene;
    AdDraw.Flip;

    verschieben(mx,my,mx2,my2);
    end;
    mx:=0;my:=0;mx2:=0;my2:=0;
  end;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  mx2:=x;
  my2:=y;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var ini: TIniFile;
begin
  ini:=TIniFile.create(ExtractFilePath(ParamStr(0))+'settings.ini');

  //ini.WriteBool('Settings','F3visible',form3.Visible);

  ini.WriteInteger('Settings','F1left',form1.Left);
  ini.WriteInteger('Settings','F1top',form1.top);

  ini.WriteInteger('Settings','Iterationen',strtoint(form2.Edit1.text));
  ini.WriteInteger('Settings','Tool',form2.ComboBox1.ItemIndex);

  //ini.WriteBool('Settings','DockForms',form3.CheckBox1.Checked);

  ini.Free

end;

end.

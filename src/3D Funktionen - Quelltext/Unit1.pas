unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DGLOpenGL, ExtCtrls, OpenGL15_MainForm, inifiles;

procedure SetupGL;
procedure Render;
procedure SetupMy;
procedure BuildFont(pFontName : String);
procedure PrintText(pX,pY,pZ : double; const pText : String);
procedure RenderFunction(xmin,xmax,ymin,ymax:extended;color:integer);

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Timer2: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  NearClipping = 1;
  FarClipping  = 1000;

type Punkt = record
  x,y,z:extended;
end;

type MyColor = record
  r,g,b:byte;
end;

type KomplexeZahl = record
  x,y:extended;
end;

var
  Form1: TForm1;
  DC: HDC;  //Handle auf Zeichenfläche
  RC: HGLRC;//Rendering Context
  mdown,fontsbuild,firststart,v:boolean;
  mx,my,mx2,my2,rueckgabe,f1left,f1top:integer;
  gradx,grady,gradz,zoom,zmin,zmax,zabs,GPunkte,xminb,xmaxb,yminb,ymaxb:extended;
  Fstring:string;
  FontBase  : GLUInt;
  Zwerte: array [0..99, 0..99] of extended;

implementation

uses Unit2;

{$R *.dfm}

procedure SetupMy;
var ini: TIniFile;
begin
  mdown:=false;
  gradx:=0;
  grady:=0;
  gradz:=0;
  GPunkte:=5; //;)
  zoom:=0;
  zmin:=0;
  zmax:=0;
  rueckgabe:=0;
  Fstring:='';
  fontsbuild:=false;
  xminb:=-1;
  xmaxb:=1;
  yminb:=-1;
  ymaxb:=1;
  firststart:=true;
  v:=true;

  ini:=TIniFile.create(ExtractFilePath(ParamStr(0))+'settings.ini');

    f1left:=ini.ReadInteger('Settings','F1L',250);
    f1top:=ini.ReadInteger('Settings','F1T',10);
    v:=ini.ReadBool('Settings','Firstrun',true);

  ini.free;

    form1.Left:=f1left;
    form1.Top:=f1top; 
end;

procedure SetupGL;
begin
  glClearColor(1, 1, 1, 0.0); //Hintergrundfarbe: Hier ein weiß
  glEnable(GL_DEPTH_TEST);          //Tiefentest aktivieren
  //glEnable(GL_CULL_FACE);           //Backface Culling aktivieren
end;

procedure BuildFont(pFontName : String); //(C) delphigl.com aus OpenGL 1.5 Template (VCL)
var
 Font : HFONT;
begin
// Displaylisten für 256 Zeichen erstellen
FontBase := glGenLists(96);
// Fontobjekt erstellen
Font     := CreateFont(16, 0, 0, 0, FW_MEDIUM, 0, 0, 0, ANSI_CHARSET, OUT_TT_PRECIS, CLIP_DEFAULT_PRECIS,
                       ANTIALIASED_QUALITY, FF_DONTCARE or DEFAULT_PITCH, PChar(pFontName));
// Fontobjekt als aktuell setzen
SelectObject(DC, Font);
// Displaylisten erstellen
wglUseFontBitmaps(DC, 0, 256, FontBase);

fontsbuild:=true;

// Fontobjekt wieder freigeben
DeleteObject(Font)
end;

procedure PrintText(pX,pY,pZ : double; const pText : String); //(C) delphigl.com aus OpenGL 1.5 Template (VCL)
begin
if (pText = '') then exit;
  glcolor3f(0,0,0);
 glPushAttrib(GL_LIST_BIT);
 //glRasterPos2i(pX, pY);
 //glRasterPos2d(pX, pY);
 glRasterPos3d(px,py,pz);
 glListBase(FontBase);
 glCallLists(Length(pText), GL_UNSIGNED_BYTE, PChar(pText));
glPopAttrib;
end;

function CColor(r,g,b:byte):MyColor;
begin
  CColor.r:=r;
  CColor.g:=g;
  CColor.b:=b;
end;

function PPunkt(x,y,z:integer):Punkt;
begin
  PPunkt.x:=x;
  PPunkt.y:=y;
  PPunkt.z:=z;
end;

procedure RenderCube(p1,p2,p3,p4:Punkt;c1,c2,c3,c4:MyColor); overload;
begin
  glBegin(GL_QUADS); //http://wiki.delphigl.com/index.php/glBegin
    glColor3f(c1.r, c1.g, c1.b); glVertex3f(p1.x, p1.y, p1.z);
    glColor3f(c2.r, c2.g, c2.b); glVertex3f(p2.x, p2.y, p2.z);
    glColor3f(c3.r, c3.g, c3.b); glVertex3f(p3.x, p3.y, p3.z);
    glColor3f(c4.r, c4.g, c4.b); glVertex3f(p4.x, p4.y, p4.z);;
  glEnd;
end;

procedure RenderCube(p1,p2,p3,p4:Punkt); overload;
begin
  glBegin(GL_QUADS); //http://wiki.delphigl.com/index.php/glBegin
    glColor3f(0, 0, 0); glVertex3f(p1.x, p1.y, p1.z);
    glColor3f(0, 0, 0); glVertex3f(p2.x, p2.y, p2.z);
    glColor3f(0, 0, 0); glVertex3f(p3.x, p3.y, p3.z);
    glColor3f(0, 0, 0); glVertex3f(p4.x, p4.y, p4.z);;
  glEnd;
end;

procedure Render3DCube;
begin

  //Vorderseite:
  RenderCube(PPunkt(-1,-1,-1),PPunkt(1,-1,-1),PPunkt(1,1,-1),PPunkt(-1,1,-1));
  //RenderCube(PPunkt(-1,-1,-1),PPunkt(-1,1,-1),PPunkt(1,1,-1),PPunkt(1,-1,-1));
  //RechteSeite:
  RenderCube(PPunkt(1,-1,-1),PPunkt(1,-1,1),PPunkt(1,1,1),PPunkt(1,1,-1));
  //RenderCube(PPunkt(1,-1,-1),PPunkt(1,1,-1),PPunkt(1,1,1),PPunkt(1,-1,1));
  //LinkeSeite:
  RenderCube(PPunkt(-1,-1,-1),PPunkt(-1,-1,1),PPunkt(-1,1,1),PPunkt(-1,1,-1));
  //RenderCube(PPunkt(-1,-1,-1),PPunkt(-1,1,-1),PPunkt(-1,1,1),PPunkt(-1,-1,1));
  //Rückseite:
  RenderCube(PPunkt(-1,-1,1),PPunkt(1,-1,1),PPunkt(1,1,1),PPunkt(-1,1,1));
  //RenderCube(PPunkt(-1,-1,1),PPunkt(-1,1,1),PPunkt(1,1,1),PPunkt(1,-1,1));

end;

procedure RenderFonts;
begin
  PrintText(0,-1,-1.25,'Real');
  PrintText(1.25,-1,0,'Imag');

  PrintText(0,-1,1.25,'Real');
  PrintText(-1.25,-1,0,'Imag');

  PrintText(-1.2,0,1,'f(z)');
  PrintText(-1.2,0,-1,'f(z)');
  PrintText(1.2,0,1,'f(z)');
  PrintText(1.2,0,-1,'f(z)');
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

function ZFunction(x,y:extended):extended;
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

  case rueckgabe of
  0:zrueck:=z.x;
  1:zrueck:=z.y;
  2:zrueck:=sqrt(sqr(Z.x)+sqr(z.y));
  end;

  ZFunction:=-1+zrueck*2; //-1 + Z*2 , -1; *2 Dient als Ausgleich für die Pos. des Würfels.
end;

procedure RenderFunction(xmin,xmax,ymin,ymax:extended;color:integer);
var x1,y1,xabs,yabs,xyabs,xgp,ygp:extended;
    p1,p2,p3,p4:Punkt;
    xlauf,ylauf:integer;
begin

  x1:=xmin;
  y1:=ymin;

  //xabs:=xmax-xmin;
  //yabs:=ymax-ymin;
  //zabs:=(zmax-zmin)/2;

  //xabs:=(abs(xmin)-abs(xmax))*2;
  //yabs:=(abs(ymin)-abs(ymax))*2;
  //zabs:=(abs(zmin+1)-abs(zmax-1));
  //zabs:=0;

  //xyabs:=(xmax-xmin)/2;
  xgp:=(xmax-xmin)/2;
  ygp:=(ymax-ymin)/2;

  xabs:=(xmin*(-1))*2-(xmax-xmin-1);
  yabs:=(ymin*(-1))*2-(ymax-ymin-1);
  zabs:=(zmin*(-1))*2-(zmax-zmin);

  form2.Edit3.Text:=floattostr(zmin);
  form2.Edit4.Text:=floattostr(zmax);
  
  if color=-1 then zabs:=0;
  //zabs:=0;
  //yabs:=0;
  //xabs:=0;

  xlauf:=0;
  ylauf:=0;

  repeat

  with p1 do begin
    x:=-1+x1*2+(xabs);
    //y:=ZFunction(x1,y1)+(zabs/2);
    if color=0 then zwerte[xlauf,ylauf]:=ZFunction(x1,y1);
    if color<>0 then y:=zwerte[xlauf,ylauf]+(zabs/2);
    z:=-1+y1*2+(yabs);
  end;

    //if (ZFunction(x1,y1)+(zabs/2)<zmin) and (color=-1) then zmin:=ZFunction(x1,y1)+(zabs/2);
    if (color=-1) then if (ZFunction(x1,y1)+(zabs/2)<zmin) then zmin:=ZFunction(x1,y1)+(zabs/2);
    if (color=-1) then if (ZFunction(x1,y1)+(zabs/2)>zmax) then zmax:=ZFunction(x1,y1)+(zabs/2);

  with p2 do begin
    x:=-1+(x1+xgp/GPunkte)*2+(xabs);
    //y:=ZFunction(x1+xgp/GPunkte,y1)+(zabs/2);
    if color=0 then zwerte[xlauf+1,ylauf]:=ZFunction(x1+xgp/GPunkte,y1);
    if color<>0 then y:=zwerte[xlauf+1,ylauf]+(zabs/2);
    z:=-1+y1*2+(yabs);
  end;

    if (color=-1) then if (ZFunction(x1+xgp/GPunkte,y1)+(zabs/2)<zmin) then zmin:=ZFunction(x1+xgp/GPunkte,y1)+(zabs/2);
    if (color=-1) then if (ZFunction(x1+xgp/GPunkte,y1)+(zabs/2)>zmax) then zmax:=ZFunction(x1+xgp/GPunkte,y1)+(zabs/2);

  y1:=y1+ygp/GPunkte;
  ylauf:=ylauf+1;

  with p3 do begin
    x:=-1+(x1+xgp/GPunkte)*2+(xabs);
    //y:=ZFunction(x1+xgp/GPunkte,y1)+(zabs/2);
    if color=0 then zwerte[xlauf+1,ylauf]:=ZFunction(x1+xgp/GPunkte,y1);
    if color<>0 then y:=zwerte[xlauf+1,ylauf]+(zabs/2);
    z:=-1+y1*2+(yabs);
  end;

    if (color=-1) then if (ZFunction(x1+xgp/GPunkte,y1)+(zabs/2)<zmin) then zmin:=ZFunction(x1+xgp/GPunkte,y1)+(zabs/2);
    if (color=-1) then if (ZFunction(x1+xgp/GPunkte,y1)+(zabs/2)>zmax) then zmax:=ZFunction(x1+xgp/GPunkte,y1)+(zabs/2);

  with p4 do begin
    x:=-1+x1*2+(xabs);
    //y:=ZFunction(x1,y1)+(zabs/2);
    if color=0 then zwerte[xlauf,ylauf]:=ZFunction(x1,y1);
    if color<>0 then y:=zwerte[xlauf,ylauf]+(zabs/2);
    z:=-1+y1*2+(yabs);
  end;

    if (color=-1) then if (ZFunction(x1,y1)+(zabs/2)<zmin) then zmin:=ZFunction(x1,y1)+(zabs/2);
    if (color=-1) then if (ZFunction(x1,y1)+(zabs/2)>zmax) then zmax:=ZFunction(x1,y1)+(zabs/2);

  if color<>-1 then begin
    case color of
    1:  begin RenderCube(p1,p2,p3,p4);
              //RenderCube(p1,p4,p3,p2);
        end;
    2:  begin RenderCube(p1,p2,p3,p4,CColor(255,0,0),CColor(0,255,0),CColor(0,0,255),CColor(80,80,80));
              //RenderCube(p1,p4,p3,p2,CColor(255,0,0),CColor(0,255,0),CColor(0,0,255),CColor(80,80,80));
        end;
    end;
  end;

  p1:=p4;
  p2:=p3;

  y1:=y1+ygp/GPunkte;
  ylauf:=ylauf+1;

  repeat

    with p3 do begin
      x:=-1+(x1+xgp/GPunkte)*2+(xabs);
      //y:=ZFunction(x1+xgp/GPunkte,y1)+(zabs/2);
      if color=0 then zwerte[xlauf+1,ylauf]:=ZFunction(x1+xgp/GPunkte,y1);
      if color<>0 then y:=zwerte[xlauf+1,ylauf]+(zabs/2);
      z:=-1+y1*2+(yabs);
    end;

      if (color=-1) then if (ZFunction(x1+xgp/GPunkte,y1)+(zabs/2)<zmin) then zmin:=ZFunction(x1+xgp/GPunkte,y1)+(zabs/2);
      if (color=-1) then if (ZFunction(x1+xgp/GPunkte,y1)+(zabs/2)>zmax) then zmax:=ZFunction(x1+xgp/GPunkte,y1)+(zabs/2);

    with p4 do begin
      x:=-1+x1*2+(xabs);
      //y:=ZFunction(x1,y1)+(zabs/2);
      if color=0 then zwerte[xlauf,ylauf]:=ZFunction(x1,y1);
      if color<>0 then y:=zwerte[xlauf,ylauf]+(zabs/2);
      z:=-1+y1*2+(yabs);
    end;

      if (color=-1) then if (ZFunction(x1,y1)+(zabs/2)<zmin) then zmin:=ZFunction(x1,y1)+(zabs/2);
      if (color=-1) then if (ZFunction(x1,y1)+(zabs/2)>zmax) then zmax:=ZFunction(x1,y1)+(zabs/2);

  if color<>-1 then begin
    case color of
    1:  begin RenderCube(p1,p2,p3,p4);
              //RenderCube(p1,p4,p3,p2);
        end;
    2:  begin RenderCube(p1,p2,p3,p4,CColor(255,0,0),CColor(0,255,0),CColor(0,0,255),CColor(80,80,80));
              //RenderCube(p1,p4,p3,p2,CColor(255,0,0),CColor(0,255,0),CColor(0,0,255),CColor(80,80,80));
        end;
    end;
  end;

  p1:=p4;
  p2:=p3;

  y1:=y1+ygp/GPunkte;
  ylauf:=ylauf+1;
  
  //until y1>=ymax;
  until y1>ymax+((ygp/2)/GPunkte);

  y1:=ymin;
  ylauf:=0;

  x1:=x1+xgp/GPunkte;
  xlauf:=xlauf+1;

  until x1>xmax-xgp/GPunkte+((xgp/2)/GPunkte);

    //showmessage('zmin: '+floattostr(zmin)+' zmax: '+floattostr(zmax));

end;

procedure Render;
var xscale,yscale,zscale:extended;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  gluPerspective(45.0, form1.ClientWidth/form1.ClientHeight, NearClipping, FarClipping);
 
  glMatrixMode(GL_MODELVIEW);
  //glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
 
  glTranslatef(0, 0, -5);

  glRotatef(gradx,0,1,0); //Wird zum drehen benötigt
  glRotatef(grady,1,0,0);
  glRotatef(gradz,0,0,1);

  glScalef(1+zoom,1+zoom,1+zoom);

  glPolygonMode(GL_FRONT_AND_BACK,GL_LINE); //Erzeugt den "Wireframe-Effekt -> http://wiki.delphigl.com/index.php/glPolygonMode

  if form2.CAA.Checked=true then glEnable(GL_Line_Smooth);

  Render3DCube;

  if form2.CheckBox2.Checked=true then Renderfonts;

  if Fstring<>'' then begin

    //RenderFunction(xminb,xmaxb,yminb,ymaxb,0);

    //xscale:=1/((abs(xminb)+abs(xmaxb)));
    //yscale:=1/((abs(yminb)+abs(ymaxb)));
    //zscale:=1/((abs(zmin)+abs(zmax))/2);
    //zscale:=1/10;

    xscale:=1/(xmaxb-xminb);
    yscale:=1/(ymaxb-yminb);
    zscale:=2/(zmax-zmin);

    glScalef(xscale,zscale,yscale);

    if form2.CheckBox1.Checked=true then RenderFunction(xminb,xmaxb,yminb,ymaxb,1);

    glPolygonMode(GL_FRONT_AND_BACK,GL_FILL); //"Normales Aussehen"

    RenderFunction(xminb,xmaxb,yminb,ymaxb,2);

  end;

  if form2.CAA.Checked=true then glDisable(GL_Line_Smooth);
 
  SwapBuffers(DC);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SetupMy;

  DC:= GetDC(Handle);
  if not InitOpenGL then Application.Terminate;
  RC:= CreateRenderingContext( DC,
                               [opDoubleBuffered],
                               32,
                               24,
                               0,0,0,
                               0);
  ActivateRenderingContext(DC, RC);

  SetupGL;

  //render;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  DeactivateRenderingContext;
  DestroyRenderingContext(RC);
  ReleaseDC(Handle, DC);
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If Button=mbleft then begin
    mx2:=x;
    my2:=y;
    mdown:=true;
  end;
end;

procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If Button=mbleft then begin
    mdown:=false;
    //showmessage(floattostr(xrot));
  end;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (mdown=true) then begin

    if mx2<>x then begin
      gradx:=gradx+(mx2-x)/400*40*-1;
      if gradx>360 then gradx:=gradx-360;
      if gradx<0 then gradx:=gradx+360;

      mx2:=x;
    end;

    if my2<>x then begin
      grady:=grady+(my2-y)/400*40*-1;
      if grady>360 then grady:=grady-360;
      if grady<0 then grady:=grady+360;

      my2:=y;
    end;

    Render;
    
  end;
end;

procedure TForm1.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  if zoom<1 then zoom:=zoom+0.05;
  render;
end;

procedure TForm1.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  if zoom>-0.6 then zoom:=zoom-0.05;
  render;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  form1.Timer1.Enabled:=false;
  render;
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

  if (form1move and form2.CheckBox3.Checked) or firststart then begin

  form2.Left:=form1.Left-240;
  form2.Top:=form1.Top;

  firststart:=false;

  end;

end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin

dockforms;

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var ini: TIniFile;
begin
  ini:=TIniFile.create(ExtractFilePath(ParamStr(0))+'settings.ini');

    ini.WriteInteger('Settings','F1L',form1.Left);
    ini.WriteInteger('Settings','F1T',form1.Top);
    ini.WriteBool('Settings','Firstrun',false);

  ini.free;
end;

end.

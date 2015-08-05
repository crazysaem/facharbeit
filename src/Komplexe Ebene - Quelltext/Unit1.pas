unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdDraws, AdClasses, AdTypes, AdPNG, AdCanvas, IniFiles, math;

procedure drawscene;
function form1move():boolean;
procedure dockforms;
function winkel:extended;

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
    AdDraw:TAdDraw;
    //AdPerCounter:TAdPerformanceCounter;
    AdImageList:TAdImageList;
    procedure Idle(Sender:TObject;var Done:boolean);
    //procedure SetLine;
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  mdown,firststart:boolean;
  mx,my,f1left,f1top:integer;

implementation

uses Unit2, Unit3;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var ini: TIniFile;
    breite,hoehe,f1l,f1t:integer;
    v2:boolean;
begin

  firststart:=true;

  ini:=TIniFile.create(ExtractFilePath(ParamStr(0))+'settings.ini');

  breite:=ini.ReadInteger('Settings','Breite',700);
  hoehe:=ini.ReadInteger('Settings','Hoehe',500);

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

  form1.Width:=breite;
  form1.Height:=hoehe;

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
  form3.Top:=form1.Top+180;

  firststart:=false;

  end;

end;

function winkel:extended;
var cosa:extended;
begin
  cosa:=(1*strtoint(form2.Edit1.Text))/( 1*(sqrt(sqr(strtoint(form2.Edit1.Text))+sqr(strtoint(form2.Edit2.Text)) ) ));
  if strtoint(form2.Edit2.Text)<0 then begin winkel:=360-RadToDeg(ArcCos(cosa));exit; end;
  winkel:=RadToDeg(ArcCos(cosa));
end;

procedure drawscene;
var x0,y0,e1,e2,lauf:integer;
begin

 with form1.AdDraw.Canvas do
    begin
      x0:=trunc(form1.clientWidth/2);
      y0:=trunc(form1.clientHeight/2);
        //<Koordinatensystem zeichnen>
        pen.Width:=1;
        MoveTo(trunc(x0),0);
        LineTo(trunc(x0),trunc(form1.Height));
        MoveTo(0,trunc(y0));
        LineTo(trunc(form1.Width),trunc(y0));

        //Arrow(5,90,AdPoint(form1.ClientWidth-10,y0),AdPoint(form1.ClientWidth,y0));

        //Arrow(30,0,AdPoint(100,100),AdPoint(20,20));

        pen.Width:=1;

        lauf:=0;

        Textout(x0+5,y0+3,inttostr(0));

        repeat
        lauf:=lauf+10;

        MoveTo(x0+lauf,y0-5);
        LineTo(x0+lauf,y0+5);

        Pen.Color:=Ad_ARGB(30, 0, 0, 0);

        MoveTo(x0+lauf,0);
        LineTo(x0+lauf,form1.Height);

        Pen.Color:=Ad_ARGB(255, 0, 0, 0);

        if (trunc(lauf/10) MOD 5) = 0 then begin
        if (trunc(lauf/10) DIV 5) = 1 then Textout(x0+lauf-2,y0+6,inttostr(trunc(lauf/10))) else Textout(x0+lauf-6,y0+6,inttostr(trunc(lauf/10)));
        pen.Width:=2;
        MoveTo(x0+lauf,y0-5);
        LineTo(x0+lauf,y0+5);
        pen.Width:=1;
        end;

        until (x0+lauf>form1.Width);

        lauf:=0;

        repeat
        lauf:=lauf-10;

        MoveTo(x0+lauf,y0-5);
        LineTo(x0+lauf,y0+5);

        Pen.Color:=Ad_ARGB(30, 0, 0, 0);

        MoveTo(x0+lauf,0);
        LineTo(x0+lauf,form1.Height);

        Pen.Color:=Ad_ARGB(255, 0, 0, 0);

        if (trunc(lauf/10) MOD -5) = 0 then begin
        if (trunc(lauf/10) DIV -5) = 1 then Textout(x0+lauf-5,y0+6,inttostr(trunc(lauf/10))) else Textout(x0+lauf-10,y0+6,inttostr(trunc(lauf/10)));
        pen.Width:=2;
        MoveTo(x0+lauf,y0-5);
        LineTo(x0+lauf,y0+5);
        pen.Width:=1;
        end;

        until (x0+lauf<0);

        lauf:=0;

        repeat
        lauf:=lauf+10;

        MoveTo(x0-5,y0+lauf);
        LineTo(x0+5,y0+lauf);

        Pen.Color:=Ad_ARGB(30, 0, 0, 0);

        MoveTo(0,y0+lauf);
        LineTo(form1.Width,y0+lauf);

        Pen.Color:=Ad_ARGB(255, 0, 0, 0);

        if (trunc(lauf/10) MOD 5) = 0 then begin
        if (trunc(lauf/10) DIV 5) = 1 then Textout(x0+6,y0+lauf-7,inttostr(trunc(-lauf/10))) else if (trunc(lauf/10) DIV 5) > 1 then Textout(x0+6,y0+lauf-7,inttostr(trunc(-lauf/10)));
        if (trunc(lauf/10) DIV 5) = -1 then Textout(x0+6,y0+lauf-7,inttostr(trunc(-lauf/10))) else if (trunc(lauf/10) DIV 5) < -1 then Textout(x0+6,y0+lauf-7,inttostr(trunc(-lauf/10)));

        if (trunc(lauf/10) DIV 5) <> 0 then begin
        pen.Width:=2;
        MoveTo(x0-5,y0+lauf);
        LineTo(x0+5,y0+lauf);
        pen.Width:=1;
        end;

        end;

        until (y0+lauf>form1.Height);

        lauf:=0;

        repeat
        lauf:=lauf-10;

        MoveTo(x0-5,y0+lauf);
        LineTo(x0+5,y0+lauf);

        Pen.Color:=Ad_ARGB(30, 0, 0, 0);

        MoveTo(0,y0+lauf);
        LineTo(form1.Width,y0+lauf);

        Pen.Color:=Ad_ARGB(255, 0, 0, 0);

        if (trunc(lauf/10) MOD 5) = 0 then begin
        if (trunc(lauf/10) DIV 5) = 1 then Textout(x0+6,y0+lauf-7,inttostr(trunc(-lauf/10))) else if (trunc(lauf/10) DIV 5) > 1 then Textout(x0+6,y0+lauf-7,inttostr(trunc(-lauf/10)));
        if (trunc(lauf/10) DIV 5) = -1 then Textout(x0+6,y0+lauf-7,inttostr(trunc(-lauf/10))) else if (trunc(lauf/10) DIV 5) < -1 then Textout(x0+6,y0+lauf-7,inttostr(trunc(-lauf/10)));

        if (trunc(lauf/10) DIV 5) <> 0 then begin
        pen.Width:=2;
        MoveTo(x0-5,y0+lauf);
        LineTo(x0+5,y0+lauf);
        pen.Width:=1;
        end;

        end;

        until (y0+lauf<0);

        //</>

        Textout(form1.Width-45,y0+20,'Re - x');
         Textout(x0-45,1,'Im - y');

      e1:=0;
      e2:=0;
      try
      e1:=trunc(strtofloat(form2.edit1.text));
      e2:=trunc(strtofloat(form2.edit2.text));
      except
      end;

        //Rectangle(x0+e1-2,y0-e2+2,x0+strtoint(form2.edit1.text),y0-strtoint(form2.edit2.text));

        Pen.Color:=Ad_ARGB(255,255,0,0);

        Brush.Color :=Ad_ARGB(255,255,0,0);

        if mdown then begin

        //Circle(trunc((mx-x0)/10),trunc((my-y0)/10)*-1,2);

        form2.Edit1.Text:=inttostr(trunc((mx-x0)/10));  //inttostr(trunc(mx/10-24));
        form2.Edit2.Text:=inttostr(trunc((my-y0)/10)*-1);  //inttostr(trunc(my/10-23)*-1);
        {
        Circle(x0+e1*10,y0-e2*10,2);

        end else begin

        Circle(x0+e1*10,y0-e2*10,2);

        end;}
        end;

        Pen.Color:=Ad_ARGB(255, 0, 0, 200);

        if form3.CheckBox2.Checked=true then begin

          moveto(x0+e1*10,y0);
          lineto(x0+e1*10,y0-e2*10);

          moveto(x0,y0-e2*10);
          lineto(x0+e1*10,y0-e2*10);

          Pen.Color:=Ad_ARGB(255, 0, 255, 0);

          moveto(x0,y0);
          lineto(x0+e1*10,y0-e2*10);

          Pen.Color:=Ad_ARGB(255, 0, 0, 0);

          case form3.ComboBox1.ItemIndex of
          0:  begin Textout(x0+e1*10+5,y0-e2*10,'P('+form2.Edit1.Text+';'+form2.Edit2.Text+')');
                    Textout(x0+e1*5,y0-e2*5,'Z = '+form2.Edit1.Text+' + '+form2.Edit2.Text+'*i');
              end;
          1:  begin Textout(x0+e1*10+5,y0-e2*10,'Z = '+floattostrF( sqrt(sqr(strtoint(form2.Edit1.Text))+sqr(strtoint(form2.Edit2.Text)) ), ffFixed, 8, 0)+'*(cos('+floattostrF(winkel, ffFixed, 8, 0)+') + sin('+floattostrF(winkel, ffFixed, 8, 0)+')*i)');
                    Textout(x0+e1*5,y0-e2*5,'r = '+floattostrF( sqrt(sqr(strtoint(form2.Edit1.Text))+sqr(strtoint(form2.Edit2.Text)) ), ffFixed, 8, 2) );
                    Textout(x0+e1*2,y0-e2*2,'Phi = '+floattostrF(winkel, ffFixed, 8, 2)+'°');
              end;
          end;

        end;

        Pen.Color:=Ad_ARGB(255,255,0,0);

        Circle(x0+e1*10,y0-e2*10,2);

        Pen.Color:=Ad_ARGB(255, 0, 0, 0);

      Release; //<-- Lässt man diese Zeile weg, wird nichts gezeichnet

      end;

      sleep(1);
end;

procedure TForm1.Idle(Sender: TObject; var Done: boolean);
begin
  if AdDraw.CanDraw then //Wenn überhaupt auf das AdDraw gezeichnet werden kann dann...
  begin
    AdDraw.ClearSurface(clWhite); //Füllt die Oberfläche mit schwarzer Farbe

    AdDraw.BeginScene;
    //Zwischen diesen beiden Zeilen müssen später unsere Zeichenfunktionen stehen

    //AdImageList.Find('koordsys').StretchDraw(AdDraw,AdRect(0,0,form1.Width,form1.Height),0);

    drawscene;

    dockforms;

    AdDraw.EndScene;

    AdDraw.Flip; //Präsentiert die gezeichneten Dinge auf dem Bildschirm.
  end;

  //sleep(25);
  //Done := false; // Diese Zeile nicht vergessen, sonst wird der Code nur sporadisch ausgeführt.

end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then begin
  mdown:=true;
  mx:=x;
  my:=y;
  end;
end;

procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  mdown:=false;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  mx:=x;
  my:=y;
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

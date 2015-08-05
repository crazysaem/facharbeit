unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Label5: TLabel;
    Label1: TLabel;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Button2: TButton;
    Label3: TLabel;
    MainMenu1: TMainMenu;
    Datei1: TMenuItem;
    Extras1: TMenuItem;
    Beenden1: TMenuItem;
    Info1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure Info1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
  var  ThreadId: Cardinal;
begin
  {
  if firststart=true then begin

    iter:=100;

    sleep(10);

    form2.Button1.Visible:=false;
    form2.Label5.Visible:=true;

    zoom(20,20,form1.ClientWidth-20,form1.ClientHeight-20);

    sleep(10);

    iter:=strtoint(form2.Edit1.text);

    drawmandelbrot(-2,1,-1,1);

    xa:=-2;
    xe:=1;
    ya:=1;
    ye:=-1;

    sleep(10);

    form2.Button1.Visible:=true;
    form2.Label5.Visible:=false;

    firststart:=false;

    exit;
  end; }

  iter:=strtoint(form2.Edit1.text);

  sleep(10);

  form2.Button1.Visible:=false;
  form2.Label5.Visible:=true;

  drawmandelbrot(-2,1,-1,1);

  form2.Button1.Visible:=true;
  form2.Label5.Visible:=false;

  xa:=-2;
  xe:=1;
  ya:=1;
  ye:=-1;

end;

procedure TForm2.Edit1Change(Sender: TObject);
begin
  if edit1.Text='' then iter:=0 else iter:=strtoint(edit1.Text);
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  form1.Close;
end;

procedure TForm2.ComboBox1Change(Sender: TObject);
begin
  tool:=form2.ComboBox1.ItemIndex;
  if tool=0 then form1.Cursor:=crcross;
  if tool=1 then form1.Cursor:=crHandPoint;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin

  iter:=strtoint(form2.Edit1.text);

  sleep(10);

  form2.Button2.Visible:=false;
  form2.Label3.Visible:=true;

  zoom(0,0,form1.ClientWidth,form1.ClientHeight);

  form2.Button2.Visible:=true;
  form2.Label3.Visible:=false;

end;

procedure TForm2.Beenden1Click(Sender: TObject);
begin
  form1.Close;
end;

procedure TForm2.Info1Click(Sender: TObject);
begin
  showmessage('Dieses Programm wurde für eine Facharbeit geschrieben.'+#10+#13+
              'Thema: Darstellung der komplexen Zahlen'+#10+#13+
              'Lehrer: Herr Kaeufer'+#10+#13+
              'Schueler/Author: Samuel Schneider');
end;

end.

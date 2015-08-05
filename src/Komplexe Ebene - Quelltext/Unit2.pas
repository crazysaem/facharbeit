unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, JvComponentBase, JvFormMagnet;

procedure EditChange;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    MainMenu1: TMainMenu;
    Datei1: TMenuItem;
    Beenden1: TMenuItem;
    Extras1: TMenuItem;
    ber1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure Einstellungen1Click(Sender: TObject);
    procedure ber1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1, Unit3;

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  form2.visible:=true;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  form1.close;
end;

procedure EditChange;
var e1,e2:integer;
begin

  e1:=0;
  e2:=0;
  try
  e1:=strtoint(form2.edit1.text);
  e2:=strtoint(form2.edit2.text);
  except
  end;

  form2.Label3.Caption:='Z = '+inttostr(e1)+' + '+inttostr(e2)+'*i';
end;

procedure TForm2.Edit1Change(Sender: TObject);
begin
  //if edit1.text='' then edit1.text:='0';
  EditChange;
end;

procedure TForm2.Edit2Change(Sender: TObject);
begin
  //if edit2.text='' then edit2.text:='0';
  EditChange;
end;

procedure TForm2.Beenden1Click(Sender: TObject);
begin
  form1.Close;
end;

procedure TForm2.Einstellungen1Click(Sender: TObject);
begin
  if form3.Visible then form3.visible:=false else form3.visible:=true;
end;

procedure TForm2.ber1Click(Sender: TObject);
begin
  showmessage('Dieses Programm wurde für eine Facharbeit geschrieben.'+#10+#13+
              'Thema: Darstellung der komplexen Zahlen'+#10+#13+
              'Lehrer: Herr Kaeufer'+#10+#13+
              'Schueler/Author: Samuel Schneider');
end;

end.

unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, JvComponentBase, JvFormMagnet;

procedure EditChange;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    MainMenu1: TMainMenu;
    Datei1: TMenuItem;
    Beenden1: TMenuItem;
    Extras1: TMenuItem;
    ber1: TMenuItem;
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure Einstellungen1Click(Sender: TObject);
    procedure ber1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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
begin
end;

procedure TForm2.Edit1Change(Sender: TObject);
begin
  //if edit1.text='' then edit1.text:='0';
  //EditChange;
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

procedure TForm2.Button1Click(Sender: TObject);
begin
  Fstring:=form2.Edit2.Text;
  xa:=strtoint(form2.Edit3.text);
  xe:=strtoint(form2.Edit4.text);
  ya:=strtoint(form2.Edit5.text);
  ye:=strtoint(form2.Edit6.text);

  if xa>=xe then begin
    showmessage('Die untere Grenze muss kleiner als die obere Grenze sein');
    exit;
  end;

  if ya>=ye then begin
    showmessage('Die untere Grenze muss kleiner als die obere Grenze sein');
    exit;
  end;

  xmin:=2147483647;
  xmax:=-2147483647;
  ymin:=2147483647;
  ymax:=-2147483647;

  form2.Label3.Visible:=true;
  form2.Button1.Visible:=false;

  form3.Button2.Click;

  form2.Label3.Visible:=false;
  form2.Button1.Visible:=true;

  //showmessage(' '+floattostr(xmin)+' '+floattostr(xmax)+' '+floattostr(ymin)+' '+floattostr(ymax));

end;

end.

unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles, JvComponentBase, JvFormMagnet;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    ComboBox1: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm3.FormCreate(Sender: TObject);
var ini: TIniFile;
    v,v2,v3:boolean;
begin

  ini:=TIniFile.create(ExtractFilePath(ParamStr(0))+'settings.ini');

  v:=ini.ReadBool('Settings','F3visible',true);
  v2:=ini.ReadBool('Settings','DockForms',true);
  v3:=ini.ReadBool('Settings','Beschr',true);

  ini.Free;

  //showmessage(booltostr(v,true));

  form3.Label3.Caption:='Die oben gennanten Angaben'+#10+#13+
                        'verändern die Breite und Höhe'+#10+#13+
                        'des Koordinatensystem-Fensters.'+#10+#13+
                        'Dadurch vergrößert bzw. verkleinert'+#10+#13+
                        'sich das Koordinatensystem.';

  edit1.Text:=inttostr(form1.Width);
  edit2.Text:=inttostr(form1.height);

  sleep(10);

  form3.Visible:=v;

  form3.CheckBox1.Checked:=v2;

  form3.CheckBox2.Checked:=v3;

end;

procedure TForm3.Button1Click(Sender: TObject);
var ini: TIniFile;
    e1,e2:integer;
begin
  ini:=TIniFile.create(ExtractFilePath(ParamStr(0))+'settings.ini');

  e1:=strtoint(edit1.text);
  e2:=strtoint(edit2.text);
  
  if e1<250 then e1:=250;
  if e2<250 then e2:=250;

  ini.WriteInteger('Settings','Breite',e1);
  ini.WriteInteger('Settings','Hoehe',e2);

  ini.WriteBool('Settings','DockForms',form3.CheckBox1.Checked);
  ini.WriteBool('Settings','Beschr',form3.CheckBox2.Checked);

  ini.Free;

  showmessage('Bitte starten Sie das Programm neu, um die Änderungen wirksam zu machen.');

end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  form1.Close;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  showmessage(floattostr(winkel));
end;

end.

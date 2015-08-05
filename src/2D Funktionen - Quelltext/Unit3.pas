unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles, JvComponentBase, JvFormMagnet, ExtCtrls;

type
  TForm3 = class(TForm)
    CheckBox1: TCheckBox;
    Button2: TButton;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Unit1, Unit2;

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

  sleep(10);

  form3.Visible:=v;

  form3.CheckBox1.Checked:=v2;

  //form3.CheckBox2.Checked:=v3;

end;

procedure TForm3.Button1Click(Sender: TObject);
var ini: TIniFile;
    e1,e2:integer;
begin

end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  form1.Close;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin

  if strtoint(form2.Edit1.Text)<3 then begin
    showmessage('Gitterlinien-wert zu klein.');
    exit;
  end;

  form2.Label8.Caption:='x '+form2.Edit1.Text;  

  lin:=strtoint(form2.Edit1.Text)-1;

  form1.AdDraw.ClearSurface(clWhite); //Füllt die Oberfläche mit schwarzer Farbe

    form1.AdDraw.BeginScene;

    drawscene;

    form1.AdDraw.EndScene;

    form1.AdDraw.Flip;

  //showmessage('Xmin: '+inttostr(xmin)+' xmax: '+inttostr(xmax)+' ymin: '+inttostr(ymin)+' ymax: '+inttostr(ymax));
end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin
  dockforms;
end;

end.

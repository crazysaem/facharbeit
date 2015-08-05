unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, inifiles, ExtCtrls;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Button1: TButton;
    CheckBox1: TCheckBox;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Label4: TLabel;
    CheckBox2: TCheckBox;
    Timer1: TTimer;
    ComboBox2: TComboBox;
    Label5: TLabel;
    Timer2: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBox1Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  editc:integer;

implementation

uses Unit1, Unit2;

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
var breite,hoehe:integer;
    ini: TIniFile;
begin

  try
  breite:=strtoint(form3.Edit1.text);
  hoehe:=strtoint(form3.Edit2.text);
  except
  showmessage('Diese Werte sind nicht möglich. Bitte nur Zahlen in die Eingabefelder eintragen.');
  exit;
  end;

  if ((breite/3)-(hoehe/2))>10 then begin
    showmessage('Breite und Höhe unterscheiden sich im Verhältnis.'+#10#13+
                'Das Verhältnis muss 3:2 betragen.');
    exit;
  end;

  ini:=TIniFile.create(ExtractFilePath(ParamStr(0))+'settings.ini');

  ini.WriteInteger('Settings','Breite',strtoint(form3.Edit1.text));
  ini.WriteInteger('Settings','Hoehe',strtoint(form3.Edit2.text));
  ini.WriteBool('Settings','Dock',form3.CheckBox1.Checked);
  ini.WriteInteger('Settings','Colorset',form3.ComboBox1.ItemIndex);

  ini.WriteBool('Settings','MandStart',form3.CheckBox2.Checked);

  ini.Free;

  showmessage('Bitte starten Sie das Programm neu, um die Änderungen wirksam zu machen.');

end;

procedure TForm3.Edit2Change(Sender: TObject);
begin
  {
  if editc=1 then exit;
  editc:=2;
  try
  if pstart=false then form3.Edit1.Text:=inttostr((trunc(strtoint(form3.Edit2.Text)/2*3)));
  except
  end;
  editc:=-1;}
end;

{procedure Thread_Init(Param: Pointer);
begin

repeat
sleep(1);
//application.ProcessMessages;
until (form1.AdDraw.CanDraw=true);

sleep(50);

zoom(10,10,form1.ClientWidth-10,form1.ClientHeight-10);

sleep(150);

form2.Button1.Click;

//showmessage('');

end;}

procedure TForm3.Edit1Change(Sender: TObject);
begin
  {
  if editc=2 then exit;
  editc:=1;
  try
  if pstart=false then form3.Edit2.Text:=inttostr((trunc(strtoint(form3.Edit1.Text)/3*2)));
  except
  end;
  editc:=-1;}
end;

procedure TForm3.FormCreate(Sender: TObject);
var ini: TIniFile;
    breite,hoehe,time,lauf,cset,it,tool0:integer;
    dock:boolean;
    ThreadId: Cardinal;
begin

  editc:=-1;

  ini:=TIniFile.create(ExtractFilePath(ParamStr(0))+'settings.ini');

  breite:=ini.ReadInteger('Settings','Breite',900);
  hoehe:=ini.ReadInteger('Settings','Hoehe',600);
  dock:=ini.ReadBool('Settings','Dock',true);
  mandstart:=ini.ReadBool('Settings','MandStart',true);

  form3.CheckBox2.Checked:=mandstart;
  case hoehe of
  100: form3.ComboBox2.ItemIndex:=0;
  200: form3.ComboBox2.ItemIndex:=1;
  300: form3.ComboBox2.ItemIndex:=2;
  600: form3.ComboBox2.ItemIndex:=3;
  end;

  {
  it:=ini.ReadInteger('Settings','Iterationen',100);
  tool0:=ini.ReadInteger('Settings','Tool',0);

  form2.ComboBox1.ItemIndex:=tool0;
  tool:=tool0;
  form2.Edit1.Text:=inttostr(it);
  iter:=it;

  if tool=0 then form1.Cursor:=crcross;
  if tool=1 then form1.Cursor:=crHandPoint; }

  cset:=ini.ReadInteger('Settings','Colorset',0);

  ini.free;

  form3.Edit1.Text:=inttostr(breite);
  form3.Edit2.Text:=inttostr(hoehe);
  form3.CheckBox1.Checked:=dock;

  form3.ComboBox1.ItemIndex:=cset;

  form3.label3.Caption:='Die oben gennanten Angaben'+#10+#13+
                        'verändern die Breite und Höhe'+#10+#13+
                        'des Mandelbrot-Fensters.'+#10+#13+
                        'Dadurch vergrößert bzw. verkleinert'+#10+#13+
                        'sich das Mandelbrot-Fraktal.';

  //pstart:=false;

  {
  showmessage('Das Programm wird initialisiert. Bitte warten sie,'+#10+#13+
              'bis die nächste Meldung auftaucht bevor sie das'+#10+#13+
              'das Programm benutzen. Dies ist vor jedem Programmstart'+#10+#13+
              'erforderlich.');

  for lauf:=1 to 2 do begin
  time:=gettickcount;
  repeat
  application.ProcessMessages;
  sleep(1);
  until (gettickcount-time)>1000;

  zoom(10,10,form1.ClientWidth-10,form1.ClientHeight-10);

  time:=gettickcount;

  repeat
  application.ProcessMessages;
  sleep(1);
  until (gettickcount-time)>500;

  form2.Button1.Click;
  end;}

  //BeginThread(nil, 0, @Thread_Init, nil, 0, ThreadId);
  

end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  form1.Close;
end;

procedure TForm3.ComboBox1Change(Sender: TObject);
begin
  colorset:=form3.ComboBox1.ItemIndex;
end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin
  form3.Timer1.Enabled:=false;
  if mandstart=true then begin
    form2.Button1.Click;
  end; 
end;

procedure TForm3.ComboBox2Change(Sender: TObject);
begin

  case form3.ComboBox2.ItemIndex of 
    0:begin form3.Edit1.Text:='150';form3.Edit2.Text:='100'; end;
    1:begin form3.Edit1.Text:='300';form3.Edit2.Text:='200'; end;
    2:begin form3.Edit1.Text:='450';form3.Edit2.Text:='300'; end;
    3:begin form3.Edit1.Text:='900';form3.Edit2.Text:='600'; end;
  end;
end;

procedure TForm3.Timer2Timer(Sender: TObject);
begin
  dockforms;
end;

end.

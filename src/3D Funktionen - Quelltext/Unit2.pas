unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, math, Menus;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    CheckBox1: TCheckBox;
    CAA: TCheckBox;
    Label1: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    ComboBox1: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Edit7: TEdit;
    Edit8: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    CheckBox2: TCheckBox;
    Button2: TButton;
    CheckBox3: TCheckBox;
    Label4: TLabel;
    MainMenu1: TMainMenu;
    Datei1: TMenuItem;
    Extras1: TMenuItem;
    Beenden1: TMenuItem;
    Info1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
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
begin
  if strtoint(form2.Edit2.Text)<3 then form2.Edit2.Text:='3';

  if fontsbuild=false then  BuildFont('Arial');

  if strtoint(form2.Edit5.text)>=strtoint(form2.Edit6.text) then begin
    showmessage(  'Mindestabstand und Maximalabstand dürfen nicht gleich sein'+#10#13+
                  ', bzw. der Mindestabstand darf nicht größer als der Maximalabstand sein!');
    exit;
  end;

  if strtoint(form2.Edit7.text)>=strtoint(form2.Edit8.text) then begin
    showmessage(  'Mindestabstand und Maximalabstand dürfen nicht gleich sein'+#10#13+
                  ', bzw. der Mindestabstand darf nicht größer als der Maximalabstand sein!');
    exit;
  end;

  form2.Button1.Visible:=false;
  form2.Label11.Visible:=true;

  gradx:=0;
  grady:=0;
  zoom:=0;
  Fstring:=form2.Edit1.Text;
  zmin:=0;
  zmax:=0;

  zmin:=1.1 * power(10,4932);
  zmax:=1.1 * power(10,4932)*-1;

  rueckgabe:=form2.ComboBox1.ItemIndex;

  xminb:=strtoint(form2.Edit5.text);
  xmaxb:=strtoint(form2.Edit6.text);
  yminb:=strtoint(form2.Edit7.text);
  ymaxb:=strtoint(form2.Edit8.text);

  RenderFunction(xminb,xmaxb,yminb,ymaxb,-1);
  RenderFunction(xminb,xmaxb,yminb,ymaxb,0);

  Render;

  form2.Button1.Visible:=true;
  form2.Label11.Visible:=false;
end;

procedure TForm2.Edit2Change(Sender: TObject);
begin
  if form2.Edit2.Text='' then begin
    GPunkte:=3/2;
    form2.Label1.Caption:='x 3';
    form2.Edit2.Text:='3';
    form2.Edit2.SelectAll;
    exit;
  end;

  try
    if strtoint(form2.Edit2.Text)<3 then begin
      GPunkte:=3;
      GPunkte:=GPunkte/2;
      form2.Label1.Caption:='x 3';
      //form2.Edit2.Text:='2';
      //form2.Edit2.Focused;
      //form2.Edit2.SelectAll;
      exit;
    end;
    
    GPunkte:=strtoint(form2.Edit2.Text);
  except;
    GPunkte:=3;
  end;

  form2.Label1.Caption:='x '+inttostr(trunc(GPunkte));

  GPunkte:=GPunkte/2;

end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  form1.Close;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  if v=true then begin showmessage( 'Dieses Programm wurde zum ersten Mal gestartet.'+#10+#13+
                                      'Bitte lesen sie "Readme.txt" für eine Beschreibung des Programmes.');


  end;
  
end;

procedure TForm2.Button2Click(Sender: TObject);
var test:extended;
begin
test:=1.1 * power(10,4932)*-1;

showmessage(floattostr(test));
end;

procedure editc;
begin
  try
  form2.Label4.Caption:='Funktionswerte (Z): '+#10+#13+'"'+floattostrf(strtofloat(form2.Edit3.Text), ffFixed, 2, 2)+'" bis "'+floattostrf(strtofloat(form2.Edit4.Text), ffFixed, 2, 2)+'"';
  except;
  end;
end;

procedure TForm2.Edit3Change(Sender: TObject);
begin
  editc;
end;

procedure TForm2.Edit4Change(Sender: TObject);
begin
  editc;
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

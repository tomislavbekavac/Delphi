unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
    TICQNmbr = record

    Ime : String[15];
    Prezime : String[15];
    UIN : Integer;
end;

    T4ICQContacts = Array of TICQNmbr;

  TForm5 = class(TForm)
    EdIme: TEdit;
    Label1: TLabel;
    EdPrezime: TEdit;
    Label2: TLabel;
    EdUIN: TEdit;
    Label3: TLabel;
    LblBrojac: TLabel;
    BtnStranicaNazad: TButton;
    BtnSljedecaStranica: TButton;
    BtnNovo: TButton;
    BtnOsigurati: TButton;
    BtnUcitati: TButton;
    procedure BtnStranicaNazadClick(Sender: TObject);
    procedure BtnSljedecaStranicaClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnOsiguratiClick(Sender: TObject);
    procedure BtnUcitatiClick(Sender: TObject);
  private
  fICQNmr : T4ICQContacts;
    fCurrentIndex : Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.BtnNovoClick(Sender: TObject);
begin
 SetLength(fICQNmr, length(fICQNmr)+1);
  fCurrentIndex := length(fICQNmr)-1;

  fICQNmr[fCurrentIndex].Ime := EdIme.Text;
  fICQNmr[fCurrentIndex].Prezime := EdPrezime.Text;
  fICQNmr[fCurrentIndex].UIN := StrToInt(EdUIN.Text);
  LblBrojac.Caption := IntToStr(fCurrentIndex + 1) + ' / '
                    + IntToStr(length(fICQNmr));
  BtnOsigurati.Enabled := true;
end;

procedure TForm5.BtnOsiguratiClick(Sender: TObject);
var
  f : file of TICQNmbr;
  i : Integer;
begin
          // aktualizirati:

  fICQNmr[fCurrentIndex].Ime := EdIme.Text;
  fICQNmr[fCurrentIndex].Prezime := EdPrezime.Text;
  fICQNmr[fCurrentIndex].UIN := StrToInt(EdUIN.Text);
  // osigurati:
  AssignFile(f,'C:\');
  ReWrite(f);
  for i := 0 to length(fICQNmr) - 1 do
    Write(f,fICQNmr[i]);
  CloseFile(f);
  // uspiješno osigurano.
  ShowMessage('uspiješno osigurano!');
end;

procedure TForm5.BtnSljedecaStranicaClick(Sender: TObject);
begin
 if fCurrentIndex < length(fICQNmr)-1 then
    fCurrentIndex := fCurrentIndex+1;

  EdIme.Text := fICQNmr[fCurrentIndex].Ime;
  EdPrezime.Text := fICQNmr[fCurrentIndex].Prezime;
  EdUIN.Text := IntToStr(fICQNmr[fCurrentIndex].UIN);

  LblBrojac.Caption := IntToStr(fCurrentIndex + 1) + ' / '
                    + IntToStr(length(fICQNmr));
end;

procedure TForm5.BtnStranicaNazadClick(Sender: TObject);
begin
  if fCurrentIndex > 0 then
    fCurrentIndex := fCurrentIndex-1;

  EdIme.Text := fICQNmr[fCurrentIndex].Ime;
  EdPrezime.Text := fICQNmr[fCurrentIndex].Prezime;
  EdUIN.Text := IntToStr(fICQNmr[fCurrentIndex].UIN);

  LblBrojac.Caption := IntToStr(fCurrentIndex + 1) + ' / '
                    + IntToStr(length(fICQNmr));
end;

procedure TForm5.BtnUcitatiClick(Sender: TObject);
var
  f : file of TICQNmbr;
begin
      // U sluèaju da je veè osigurano
  SetLength(fICQNmr, 0);
  // sada uèitati:
  AssignFile(f,'C:\');
  ReSet(f);
  while not eof(f) do
  begin
    SetLength(fICQNmr, length(fICQNmr)+1);
    fCurrentIndex := length(fICQNmr)-1;
    Read(f,fICQNmr[fCurrentIndex]);
  end;
  CloseFile(f);
  BtnOsigurati.Enabled:=true;
  // Index  0 :
  fCurrentIndex := 0;
  // uèitati podatke:

  EdIme.Text := fICQNmr[fCurrentIndex].Ime;
  EdPrezime.Text := fICQNmr[fCurrentIndex].Prezime;
  EdUIN.Text := IntToStr(fICQNmr[fCurrentIndex].UIN);
  // pokazati
  LblBrojac.Caption := IntToStr(fCurrentIndex + 1) + ' / '
                    + IntToStr(length(fICQNmr));
end;

end.

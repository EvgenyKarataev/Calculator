unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Menus, Buttons, ActnList, XPMan;

type
  TfmMain = class(TForm)
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    bbMC: TBitBtn;
    bbMR: TBitBtn;
    bbMS: TBitBtn;
    bbMPlus: TBitBtn;
    bbBackspace: TBitBtn;
    bbCE: TBitBtn;
    bbC: TBitBtn;
    bbDelit: TBitBtn;
    bbUmnog: TBitBtn;
    bbMinus: TBitBtn;
    bbPlus: TBitBtn;
    bbResult: TBitBtn;
    bb1naX: TBitBtn;
    bbProcent: TBitBtn;
    bbSQRT: TBitBtn;
    bb9: TBitBtn;
    bb8: TBitBtn;
    bb7: TBitBtn;
    bb6: TBitBtn;
    bb5: TBitBtn;
    bb4: TBitBtn;
    bb3: TBitBtn;
    bb2: TBitBtn;
    bb1: TBitBtn;
    bbT: TBitBtn;
    bbPlusMinus: TBitBtn;
    bb0: TBitBtn;
    ActionList1: TActionList;
    Znaki: TAction;
    Chisla: TAction;
    Operacii: TAction;
    XPManifest1: TXPManifest;
    Panel2: TPanel;
    pnOutput: TPanel;
    Panel3: TPanel;
    procedure ZnakiExecute(Sender: TObject);
    procedure ChislaExecute(Sender: TObject);
    procedure OperaciiExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbCClick(Sender: TObject);
    procedure bbBackspaceClick(Sender: TObject);
    procedure bbMPlusClick(Sender: TObject);
    procedure bbMRClick(Sender: TObject);
    procedure bbMCClick(Sender: TObject);
    procedure bbMSClick(Sender: TObject);
    procedure bbSQRTClick(Sender: TObject);
    procedure bb1naXClick(Sender: TObject);
    procedure bbProcentClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure N9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Code: Integer;
    bb: TBitBtn;
    bbP: TBitBtn;
    Oper: Integer;
    Result, Buff: Double;
  end;


var
  fmMain: TfmMain;

procedure PredOper;
implementation

uses uO;

{$R *.dfm}

                          //ПО Captionу определяес какое число и записываем его и ЕДит
procedure TfmMain.ChislaExecute(Sender: TObject);
begin
  bb := TBitBtn(Sender);                    //Преобразуем объект в кнопку
  Panel3.SetFocus;
  case StrToInt(bb.Caption) of            //Ели от 1 до 9 то проверяем первое ли это число
    1..9: if Code = 1 then pnOutput.Caption := pnOutput.Caption + bb.Caption
          else
            begin
              pnOutput.Caption := bb.Caption;
              Code := 1;                   //Перменная для проверки первое ли это число
            end;                           //Делаем чтобы не было много нулей в начале
    0: if pnOutput.Caption <> '0' then
       if Code = 1 then pnOutput.Caption := pnOutput.Caption +  bb.Caption
          else
            begin
              pnOutput.Caption := bb.Caption;
              Code := 1;
            end;
  end;
end;
                                        // Здесь ставится '.' или '+' или '-' в числе
procedure TfmMain.ZnakiExecute(Sender: TObject);
begin
  bb := TBitBtn(Sender);
  case bb.Tag of
    44: if Code = 1 then                              //Проверка чтобы не было много '.'
          if Pos(',', pnOutput.Caption) = 0 then pnOutput.Caption :=  pnOutput.Caption + ','
        else
        else
          begin
            pnOutput.Caption := '0,';
            Code := 1;
          end;                                        //'+' или '-'
   302: pnOutput.Caption := FloatToStr(StrToFloat(pnOutput.Caption) * (-1));
  end;
end;
//Предыдущая операция
procedure PredOper;
var
  Number: Double;
begin
  Number := StrToFloat(fmMain.pnOutput.Caption);
  case fmMain.Oper of
    61: fmMain.Result := Number;
    43: fmMain.Result := fmMain.Result + Number;
    42: fmMain.Result := fmMain.Result * Number;
    45: fmMain.Result := fmMain.Result - Number;
    47: if Number = 0 then ShowMessage('На ноль делить нельзя')
        else fmMain.Result := fmMain.Result / Number;
  end;
    fmMain.pnOutput.Caption := FloatToStr(fmMain.Result);
end;

procedure TfmMain.OperaciiExecute(Sender: TObject);
begin
  bb := TBitBtn(Sender);
  if Code = 0 then
    oper := bb.Tag
  else
    begin
      PredOper;
      oper := bb.Tag;
      Code := 0;
    end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  Oper := 61;  //Первая операция '='
  Buff := 0;
end;

//Кнопка очистить 'С'
procedure TfmMain.bbCClick(Sender: TObject);
begin
  Code := 0;
  pnOutput.Caption := '0';
  Oper := 61;
  Result := 0;
end;

//Backspace
procedure TfmMain.bbBackspaceClick(Sender: TObject);
var
  i: Integer;
  st: string;
begin
  if code <> 0 then
  begin
    st := pnOutput.Caption;
    pnOutput.Caption := '';
    for i := 1 to Length(st)-1 do
      pnOutput.Caption := pnOutput.Caption + st[i];
      if Length(pnOutput.Caption) = 0 then          //Ели нет чисел то присваевает '0'
        begin
          pnOutput.Caption := '0';
          Code := 0;
        end;
  end;
end;

//Память +
procedure TfmMain.bbMPlusClick(Sender: TObject);
begin
  Panel2.Caption := 'M';
  Buff := Buff + StrToFloat(pnOutput.Caption);
end;

//Вывод из памяти
procedure TfmMain.bbMRClick(Sender: TObject);
begin
  pnOutput.Caption := FloatToStr(Buff);
  if (oper = 43) or (oper = 45) or (oper = 42) or (oper = 47) then Code := 1
  else Code := 0;
end;

//Память не '+'
procedure TfmMain.bbMCClick(Sender: TObject);
begin
  Buff := 0;
  Panel2.Caption := '';
end;

//Стерает память
procedure TfmMain.bbMSClick(Sender: TObject);
begin
  Code := 0;
  Panel2.Caption := 'M';
  Buff := StrToFloat(pnOutput.Caption);
end;

//КОрень
procedure TfmMain.bbSQRTClick(Sender: TObject);
begin
  if StrToFloat(pnOutput.Caption) < 0 then
  ShowMessage('Подкоренное выражение не может быть меньше нуля!')
  else pnOutput.Caption := FloatToStr(sqrt(StrToFloat(pnOutput.Caption)));
  Code := 0;
end;

//1/х
procedure TfmMain.bb1naXClick(Sender: TObject);
begin
  if StrToFloat(pnOutput.Caption) = 0 then ShowMessage('На ноль делить нельзя')
  else pnOutput.Caption := FloatToStr(1 / StrToFloat(pnOutput.Caption));
  PredOper;
  Code := 0;
end;

//ПРоцент
procedure TfmMain.bbProcentClick(Sender: TObject);
begin
  Oper := 42;
  PredOper;
  pnOutput.Caption := FloatToStr(StrToFloat(pnOutput.Caption) / 100);
  Code := 0;
end;

procedure TfmMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ord(Key) = 27 then fmMain.bbCClick(Sender);
  if ord(Key) = 8 then fmMain.bbBackspaceClick(Sender);
  if ord(Key) = 13 then fmMain.OperaciiExecute(bbResult);
  if ord(Key) = 42 then fmMain.OperaciiExecute(bbUmnog);
  if ord(Key) = 45 then fmMain.OperaciiExecute(bbMinus);
  if ord(Key) = 43 then fmMain.OperaciiExecute(bbPlus);
  if ord(Key) = 47 then fmMain.OperaciiExecute(bbDelit);
  if ord(Key) = 44 then fmMain.ZnakiExecute(bbT);
  if ord(Key) = 48 then fmMain.ChislaExecute(bb0);
  if ord(Key) = 49 then fmMain.ChislaExecute(bb1);
  if ord(Key) = 50 then fmMain.ChislaExecute(bb2);
  if ord(Key) = 51 then fmMain.ChislaExecute(bb3);
  if ord(Key) = 52 then fmMain.ChislaExecute(bb4);
  if ord(Key) = 53 then fmMain.ChislaExecute(bb5);
  if ord(Key) = 54 then fmMain.ChislaExecute(bb6);
  if ord(Key) = 55 then fmMain.ChislaExecute(bb7);
  if ord(Key) = 56 then fmMain.ChislaExecute(bb8);
  if ord(Key) = 57 then fmMain.ChislaExecute(bb9);
end;

procedure TfmMain.N9Click(Sender: TObject);
begin
  fmO.Show;
end;

end.

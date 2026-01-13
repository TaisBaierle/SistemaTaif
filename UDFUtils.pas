unit UDFUtils;

interface

uses
  System.SysUtils, System.MaskUtils, System.RegularExpressions, DateUtils;

function ApenasNumeros(const AValue: string): string;
function FormatarDocumento(const ADocumento: string): string;
function GerarCPF: string;
function GerarDataAleatoria: TDateTime;

implementation

function ApenasNumeros(const AValue: string): string;
begin
  Result := TRegEx.Replace(AValue, '[^\d]', '');
end;

function FormatarDocumento(const ADocumento: string): string;
var
  LValue: string;
begin
  LValue := ApenasNumeros(ADocumento);

  case LValue.Length of
    11:
      Result := FormatMaskText('000\.000\.000\-00;0', LValue);
    14:
      Result := FormatMaskText('00\.000\.000\/0000\-00;0', LValue);

  else
    Result := ADocumento;
  end;
end;

function GerarCPF: string;
var
  LIndice, LSoma, LResto: Integer;
  LDigitos: array [1 .. 11] of Integer;
begin
  Randomize;

  for LIndice := 1 to 9 do
    LDigitos[LIndice] := Random(10);

  LSoma := 0;
  for LIndice := 1 to 9 do
    LSoma := LSoma + LDigitos[LIndice] * (11 - LIndice);

  LResto := LSoma mod 11;
  if LResto < 2 then
    LDigitos[10] := 0
  else
    LDigitos[10] := 11 - LResto;

  LSoma := 0;
  for LIndice := 1 to 10 do
    LSoma := LSoma + LDigitos[LIndice] * (12 - LIndice);

  LResto := LSoma mod 11;
  if LResto < 2 then
    LDigitos[11] := 0
  else
    LDigitos[11] := 11 - LResto;

  Result := '';
  for LIndice := 1 to 11 do
    Result := Result + IntToStr(LDigitos[LIndice]);
end;

function GerarDataAleatoria: TDateTime;
var
  LDataInicial, LDataFinal: TDateTime;
  LDiasIntervalo: Integer;
begin
  LDataInicial := EncodeDate(1990, 1, 1);
  LDataFinal := EncodeDate(2025, 12, 31);

  LDiasIntervalo := DaysBetween(LDataInicial, LDataFinal);

  Result := LDataInicial + Random(LDiasIntervalo);
end;

end.

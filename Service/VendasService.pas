unit VendasService;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  System.Generics.Defaults,
  Venda,
  VendasDAO,
  SistemaSorteioData;

type
  TVendasService = class
  public
    procedure InserirVendas;
  end;

implementation

procedure TVendasService.InserirVendas;
var
  LVendaDAO: TVendaDAO;
  LClientes: TList<Integer>;
  LCarros: TList<Integer>;
  LIndice: Integer;
  LVenda: TVenda;
begin
  LVendaDAO := TVendaDAO.Create;
  LClientes := nil;
  LCarros := nil;
  try
    LClientes := LVendaDAO.ObterClientesAleatorios;
    LCarros := LVendaDAO.ObterCarrosDisponiveis;

    Randomize;
    LCarros.Sort(TComparer<Integer>.Construct(
      function(const L, R: Integer): Integer
      begin
        Result := Random(3) - 1;
      end));

    for LIndice := 0 to 4 do
    begin
      LVenda := TVenda.Create;
      try
        LVenda.IdVenda := dmSistemaSorteio.ObterMax('VENDA', 'IDVENDA') + 1;
        LVenda.IdCliente := LClientes[LIndice];
        LVenda.IdCarro := LCarros[LIndice];
        LVenda.DataVenda := Date;

        LVendaDAO.InserirVenda(LVenda);
      finally
        LVenda.Free;
      end;
    end;

  finally
    LClientes.Free;
    LCarros.Free;
    LVendaDAO.Free;
  end;
end;

end.

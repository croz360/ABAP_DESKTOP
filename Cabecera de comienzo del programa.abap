*************************************************************
*PROGRAMA           : "NOMBRE_DEL_PROGRAMA"                 *
*AUTOR              : ULISES PADILLA URIBE                  *
*DESCRIPCION:       :                                       *
*FECHA              : "FECha DE REALIZACIÓN DEL PROGRAMA"   *
*************************************************************
*HISTORICO DE CAMBIOS:                                      *
*FECHA "#" AUTOR "#" TRASPORTE O REV-TRACK "#" DESCRIPCIÓN"#"*


Caso 1: Orden en estatus liberada (wa_aufk-phas1 = X)
1.1	Número de stock 07, centro 0350 y almacén 0356
IF ¿Se tiene que comprobar que no tenga operación de cosmético abierta?
1.1.1	Se le agrega actividad cosmética y se realiza movimiento de material
else Mandar mensaje de error en el cual diga que diga la orden ya tiene actividad abierta
1.1.2	Se realiza el movimiento de material

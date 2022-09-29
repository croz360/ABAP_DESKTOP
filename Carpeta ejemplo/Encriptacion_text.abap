REPORT zr_encry_upu.


START-OF-SELECTION.

  "=== Ejemplo de codigo de clave de encriptación

  DATA: lv_random       TYPE xstring,
        e_key           TYPE xstring,
        lv_data         TYPE string,
        lv_data_xstr     TYPE xstring,
        lv_iv            TYPE xstring,
        lv_key           TYPE xstring,
        lv_encrypted_str TYPE xstring,
        lv_mj            TYPE string.

  DATA: ex_cx_bcs TYPE REF TO cx_bcs.

  CALL METHOD cl_sec_sxml_writer=>generate_key
    EXPORTING
      algorithm = cl_sec_sxml_writer=>co_aes256_algorithm    " Algorithm
    RECEIVING
      key       = lv_random.    " Generated key

  DATA(lr_conv_key) = cl_abap_conv_out_ce=>create( ).

*  CLEAR: lv_random.
*
**  lv_random = '01'.

  lr_conv_key->write( data = lv_random ).

  e_key = lr_conv_key->get_buffer(  ).

  lv_data = 'hola mundo este es un mensaje encriptado ÑÑ'.

  TRY.
      "=== Convertir el mensaje string en Xstring
      lv_data_xstr = cl_bcs_convert=>string_to_xstring(
                     iv_string     = lv_data
*                   iv_convert_cp = 'X'
*                   iv_codepage   =
*                   iv_add_bom    =
                 ) .

    "=== Data Encryprion
    cl_sec_sxml_writer=>encrypt(
      EXPORTING
        plaintext  = lv_data_xstr    " Plaintext
        key        = lv_random    " Key
        algorithm  = cl_sec_sxml_writer=>co_aes256_algorithm    " Algorithm
      IMPORTING
        ciphertext = lv_encrypted_str    " Ciphertext
    ).

    write: / 'KEY'.
    write: / lv_random.
    write: / 'DATA: '.
    write: / lv_data.
    write: / 'Encrypted Data'.
    write: / lv_encrypted_str.

    cl_sec_sxml_writer=>decrypt(
      EXPORTING
        ciphertext = lv_encrypted_str    " Ciphertext
        key        = lv_random    " Key
        algorithm  = cl_sec_sxml_writer=>co_aes256_algorithm    " Algorithm
      IMPORTING
        plaintext  = data(lv_plaintext)    " Plaintext
    ).

    lv_mj = cl_bcs_convert=>xstring_to_string(
            iv_xstr   = lv_plaintext
            IV_CP     = '1100'
        ).

    write: / 'Decrypt ', / lv_plaintext.
    write: / 'Mensaje desencriptado', / lv_mj.

    CATCH cx_bcs INTO ex_cx_bcs.

      lv_mj = ex_cx_bcs->get_longtext( ).

  ENDTRY.


*                 CATCH cx_bcs.  "


*   cl_demo_output=>display(
*     EXPORTING
*       data = e_key    " Text or Data
**       name =
*   ).
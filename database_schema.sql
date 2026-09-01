-- ===========================
-- AUTH USERS DATA EXPORT
-- ===========================
-- Se carga ANTES que las migraciones: varios bloques DO mas abajo buscan estos
-- usuarios por email y, si no los encuentran, crean un placeholder con
-- gen_random_uuid(). Eso hacia que el INSERT real del export chocase con el
-- indice unico de email y se saltase, dejando huerfanos los public.profiles.
-- El trigger on_auth_user_created todavia no existe en este punto, asi que
-- estos INSERT no disparan la creacion automatica de profiles.

INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES ('00000000-0000-0000-0000-000000000000', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'authenticated', 'authenticated', 'emilio@expertpericial.com', '$2a$10$H0SzuXWA/VAm8j1EJu0/7.fDsLLFfUTLZtnye.wIL2zOJtvFSqKMC', '2025-10-24 21:07:48.90686+00', NULL, '', '2025-10-24 21:07:20.428633+00', '', NULL, '', '', NULL, '2026-07-10 11:37:49.134146+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "30e2ccb0-f8ad-45a7-b6dd-ed810c93f212", "email": "emilio@expertpericial.com", "email_verified": true, "phone_verified": false}', NULL, '2025-10-24 21:07:20.365699+00', '2026-07-10 14:34:30.617765+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false) ON CONFLICT DO NOTHING;
INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES ('00000000-0000-0000-0000-000000000000', '64e2abb7-85b7-49b0-8e3d-007ee38a1cd8', 'authenticated', 'authenticated', 'dydsoftware1@gmail.com', '$2a$10$S30kbllugc9tH7YIWdCmKefWgyebgMTxcplkvMLcm7qJioSBb9sxu', '2025-10-15 21:35:23.128105+00', NULL, '', '2025-10-15 21:27:01.562953+00', '', NULL, '', '', NULL, '2025-10-17 22:55:17.270443+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "64e2abb7-85b7-49b0-8e3d-007ee38a1cd8", "email": "dydsoftware1@gmail.com", "email_verified": true, "phone_verified": false}', NULL, '2025-10-15 21:27:01.498688+00', '2025-10-19 11:47:10.838003+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false) ON CONFLICT DO NOTHING;
INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES ('00000000-0000-0000-0000-000000000000', '11c7daf8-8a5e-4537-b6d1-3972c0abbd05', 'authenticated', 'authenticated', 'alexistomaselli@gmail.com', '$2a$10$qVC/r9woApWMpLovpmlJduaN29WCX0LAg/kAtg/t6nz2paDsrGNdy', '2025-10-14 00:14:44.16515+00', NULL, '', '2025-10-14 00:10:03.803651+00', '', NULL, '', '', NULL, '2025-10-22 14:38:07.222219+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "11c7daf8-8a5e-4537-b6d1-3972c0abbd05", "email": "alexistomaselli@gmail.com", "workshop_name": "Taller Alexis", "email_verified": true, "phone_verified": false}', NULL, '2025-10-14 00:10:03.768288+00', '2025-10-22 14:38:07.230409+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false) ON CONFLICT DO NOTHING;
INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES (NULL, '90301e4a-7fde-4b77-80c0-5c2c121ccc7d', NULL, NULL, 'admin@valoraplus.com', '$2a$10$dummy.hash.for.development.only', '2025-10-13 23:17:15.225714+00', NULL, '', NULL, '', NULL, '', NULL, NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{}', NULL, '2025-10-13 23:17:15.225714+00', '2025-10-13 23:17:15.225714+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false) ON CONFLICT DO NOTHING;
INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES ('00000000-0000-0000-0000-000000000000', '08cdb3f5-cd0a-4def-b883-7bae1f269d87', 'authenticated', 'authenticated', 'javaxtron@gmail.com', '$2a$10$1Pi87lztrjZfS76.zYvYWOvQEIMUVL.iX0gcKgUA8vZKjFFpYL0Hm', NULL, NULL, '4596958785abd4fb7a1245dca39babd347fa8f3b50ed3967353bb4ac', '2025-10-25 12:35:51.929335+00', '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"sub": "08cdb3f5-cd0a-4def-b883-7bae1f269d87", "role": "admin_mechanic", "email": "javaxtron@gmail.com", "full_name": "Javier fari\u00f1a rodriguez", "workshop_name": "Chapicar", "email_verified": false, "phone_verified": false}', NULL, '2025-10-25 12:35:51.920299+00', '2025-10-25 12:35:52.654266+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false) ON CONFLICT DO NOTHING;
INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES ('00000000-0000-0000-0000-000000000000', '485e7cd8-74c1-42e3-bd6b-1cde5ffaeb6b', 'authenticated', 'authenticated', 'info@expertpericial.com', '$2a$10$x2AEVFJ3wax40.FWykJcS.5aKyBihFeJUm4lhuPwxoCErFEiphNeW', '2025-10-24 11:58:44.538507+00', NULL, '', '2025-10-24 11:58:21.250865+00', '', NULL, '', '', NULL, '2025-10-24 11:58:58.61139+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "485e7cd8-74c1-42e3-bd6b-1cde5ffaeb6b", "role": "admin_mechanic", "email": "info@expertpericial.com", "full_name": "juan", "workshop_name": "talle ubeda", "email_verified": true, "phone_verified": false}', NULL, '2025-10-24 11:58:21.174821+00', '2025-10-25 04:25:35.461866+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false) ON CONFLICT DO NOTHING;
INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES ('00000000-0000-0000-0000-000000000000', '95eaba1c-5e43-4be5-8a48-e90e58b42cd0', 'authenticated', 'authenticated', 'hola@expertpericial.com', '$2a$10$M4FOkMhz3K/4/1OnssrIheN2e8AXHhIUXOpXj9fWN89ZgR9jgR5A6', '2025-10-25 04:43:45.828053+00', NULL, '', '2025-10-25 04:43:10.687686+00', '', NULL, '', '', NULL, '2025-10-25 04:43:45.833169+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "95eaba1c-5e43-4be5-8a48-e90e58b42cd0", "role": "admin_mechanic", "email": "hola@expertpericial.com", "full_name": "Juan Perez", "workshop_name": "Taller Extremadura", "email_verified": true, "phone_verified": false}', NULL, '2025-10-25 04:43:10.644532+00', '2025-10-25 04:43:45.845146+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false) ON CONFLICT DO NOTHING;
INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES ('00000000-0000-0000-0000-000000000000', '53107b25-ea1f-42b8-9ed7-f6d55d22127e', 'authenticated', 'authenticated', 'vmautomocion@hotmail.es', '$2a$10$/I8lJx3dBm8rKCamXsC/UeJVcMIV9nSiPB7.ZXQvGwc6QyP38oDN6', NULL, NULL, 'c6868e9eff5b1dbfd2430caa96897b4cc1ffa3e277b6f25da5273810', '2025-10-25 12:34:32.179221+00', '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"sub": "53107b25-ea1f-42b8-9ed7-f6d55d22127e", "role": "admin_mechanic", "email": "vmautomocion@hotmail.es", "full_name": "Juan Luis", "workshop_name": "VM Automocion ", "email_verified": false, "phone_verified": false}', NULL, '2025-10-25 12:34:32.130599+00', '2025-10-25 12:34:34.101698+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false) ON CONFLICT DO NOTHING;
INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES ('00000000-0000-0000-0000-000000000000', 'e29640a4-2370-4056-8a86-8ae122682ed0', 'authenticated', 'authenticated', 'demo@tallerdemo.com', '$2a$10$dummy.hash.for.development.only', '2025-10-13 23:19:01.709629+00', NULL, '', NULL, '', NULL, '', NULL, NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"workshop_name": "Taller Mec\u00e1nico Demo"}', NULL, '2025-10-13 23:19:01.709629+00', '2025-10-13 23:19:01.709629+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false) ON CONFLICT DO NOTHING;
INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES ('00000000-0000-0000-0000-000000000000', '1cbc726b-2e7e-40e5-a616-7a580f623597', 'authenticated', 'authenticated', 'info@autoreparaciones.com', '$2a$10$dummy.hash.for.development.only', '2025-10-13 23:19:01.709629+00', NULL, '', NULL, '', NULL, '', NULL, NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"workshop_name": "AutoReparaciones SL"}', NULL, '2025-10-13 23:19:01.709629+00', '2025-10-13 23:19:01.709629+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false) ON CONFLICT DO NOTHING;
INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES ('00000000-0000-0000-0000-000000000000', 'f38818fd-e683-4784-9f50-caa90e7f4256', 'authenticated', 'authenticated', 'talleresribera@hotmail.es', '$2a$10$NeDZ.rq.gJuWZuEuUE8a.O9mkv.X5zPRJCpBBy9vZNQt9Oj2oNtlW', NULL, NULL, '007479342e6c0db3243fcc424969f168aded0d373f7adbbb8fbf20dc', '2025-10-25 12:37:47.360895+00', '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"sub": "f38818fd-e683-4784-9f50-caa90e7f4256", "role": "admin_mechanic", "email": "talleresribera@hotmail.es", "full_name": "Eva V\u00e1zquez Tortajada", "workshop_name": "TALLERES RIBERA C.B. ", "email_verified": false, "phone_verified": false}', NULL, '2025-10-25 12:37:47.349732+00', '2025-10-25 12:37:48.502765+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false) ON CONFLICT DO NOTHING;
INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES ('00000000-0000-0000-0000-000000000000', '8beae8ad-96f9-44aa-b799-b90b1691cd2b', 'authenticated', 'authenticated', 'tallerescidoncha@hotmail.com', '$2a$10$aMI40dEWZGfN7CjTA1m0PeMdRis3daaqx1p8U/Sn1SGScwpUH8l8i', '2025-10-25 12:38:11.973121+00', NULL, '', '2025-10-25 12:36:45.753587+00', '', NULL, '', '', NULL, '2025-10-25 12:38:11.978118+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "8beae8ad-96f9-44aa-b799-b90b1691cd2b", "role": "admin_mechanic", "email": "tallerescidoncha@hotmail.com", "full_name": "Jose david ruiz", "workshop_name": "Talleres cidoncha", "email_verified": true, "phone_verified": false}', NULL, '2025-10-25 12:36:45.735047+00', '2025-10-25 12:38:12.002098+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false) ON CONFLICT DO NOTHING;
INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES ('00000000-0000-0000-0000-000000000000', '09a91c7c-419d-4f9e-b7d4-d2607559c146', 'authenticated', 'authenticated', 'sdsautomocion@gmail.com', '$2a$10$nUsNteWWJj9NundUKgS1lenduzcz4S3TXY4nveX3zy2f.weWwd9Qy', '2025-10-26 07:44:21.139271+00', NULL, '', '2025-10-26 07:42:51.938466+00', '', NULL, '', '', NULL, '2025-10-26 07:44:21.158617+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "09a91c7c-419d-4f9e-b7d4-d2607559c146", "role": "admin_mechanic", "email": "sdsautomocion@gmail.com", "full_name": "Sergio Bautista Carrasco", "workshop_name": "SDS AUTOMOCION", "email_verified": true, "phone_verified": false}', NULL, '2025-10-26 07:42:51.779831+00', '2025-10-26 07:44:21.203093+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false) ON CONFLICT DO NOTHING;
INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES ('00000000-0000-0000-0000-000000000000', 'b82e8e28-b1e6-468a-8ebc-a77ce99e6744', 'authenticated', 'authenticated', 'tallerchapicar@gmail.com', '$2a$10$qlvhXEPiitXdX0lYjW/OFuOGE1x/faa5RI1y9HpUQgpA0ljnX6VMq', NULL, NULL, '87239e5bf096ec5d83311235422b3e4d76031479214e1c28a7ab9546', '2025-10-25 12:39:18.969648+00', '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"sub": "b82e8e28-b1e6-468a-8ebc-a77ce99e6744", "role": "admin_mechanic", "email": "tallerchapicar@gmail.com", "full_name": "Alberto Fari\u00f1a Rodr\u00edguez ", "workshop_name": "Taller Chapicar ", "email_verified": false, "phone_verified": false}', NULL, '2025-10-25 12:39:18.959816+00', '2025-10-25 12:39:19.851067+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false) ON CONFLICT DO NOTHING;
INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES ('00000000-0000-0000-0000-000000000000', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'authenticated', 'authenticated', 'juanvelasco9888@gmail.com', '$2a$10$MXiDnHAOCZM97SZqE33wweX0rNWnfdOSKIiMyPsl1B8ozlj8EoZZa', '2025-10-22 20:29:02.889668+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-07-10 14:40:16.427078+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "2ccb2fcc-314f-4efa-8d6a-fb44862a48e1", "role": "admin_mechanic", "email": "juanvelasco9888@gmail.com", "full_name": "Juan Velasco", "workshop_name": "Taller Velasco", "email_verified": true, "phone_verified": false}', NULL, '2025-10-22 20:07:29.19968+00', '2026-07-10 14:40:16.448381+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false) ON CONFLICT DO NOTHING;
INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES ('00000000-0000-0000-0000-000000000000', 'e785f3eb-be32-4c2a-81fd-028031bb455b', 'authenticated', 'authenticated', 'dyd.ialabs@gmail.com', '$2a$10$WOkPVnDrrIw74g4C/Rm2qesBxS3V8kxJH.YtAYHxGbMRIVKpIqqdu', '2026-01-19 18:07:30.707434+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-01-19 21:25:48.424021+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "e785f3eb-be32-4c2a-81fd-028031bb455b", "role": "admin_mechanic", "email": "dyd.ialabs@gmail.com", "full_name": "Alexis Admin", "workshop_name": "Taller Admin", "email_verified": false, "phone_verified": false}', NULL, '2026-01-19 18:05:50.797206+00', '2026-02-16 01:47:20.228879+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false) ON CONFLICT DO NOTHING;
INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES ('00000000-0000-0000-0000-000000000000', '7c97bc85-8ad5-4929-adcd-0326d183e374', 'authenticated', 'authenticated', 'higini@genaisapiens.com', '$2a$10$W2tol.kbExsHM2ItXBw24.YdTxgMYCIqk7BEgVOWRdEcv6lSC74AO', '2025-11-17 18:55:53.556043+00', NULL, '', '2025-11-17 18:55:32.175304+00', '', NULL, '', '', NULL, '2025-11-17 18:55:53.56132+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "7c97bc85-8ad5-4929-adcd-0326d183e374", "role": "admin_mechanic", "email": "higini@genaisapiens.com", "full_name": "Higini", "workshop_name": "Taller Higini", "email_verified": true, "phone_verified": false}', NULL, '2025-11-17 18:55:32.011445+00', '2025-11-17 18:55:53.605023+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false) ON CONFLICT DO NOTHING;
INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES ('00000000-0000-0000-0000-000000000000', 'b0c73890-3fdf-49f2-b4af-29530c8ad59a', 'authenticated', 'authenticated', 'victorafee@gmail.com', '$2a$10$4SHc1SP3IXVkE3Jh/VeuMuILBWzExyiU/yA4.zaohpKGFNEzMsdRW', '2025-12-08 22:26:35.243055+00', NULL, '', '2025-12-08 22:25:40.106543+00', '', NULL, '', '', NULL, '2026-02-11 00:36:01.827452+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "b0c73890-3fdf-49f2-b4af-29530c8ad59a", "role": "admin_mechanic", "email": "victorafee@gmail.com", "full_name": "Victor Afe", "workshop_name": "My Mechanical Workshop", "email_verified": true, "phone_verified": false}', NULL, '2025-12-08 22:25:39.975435+00', '2026-02-12 02:32:55.383428+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false) ON CONFLICT DO NOTHING;
INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES ('00000000-0000-0000-0000-000000000000', 'd9b71b6e-2f68-4132-b204-aa8b4b1916a0', 'authenticated', 'authenticated', 'emiliogala13@gmail.com', '$2a$10$WYEVaDfJfhUGISMcFh.gluZCNJV.BrbGnfWIaMSHcbQorrtqE.D.S', '2026-01-17 08:28:01.662099+00', NULL, '', '2026-01-17 08:27:37.210484+00', '', NULL, '', '', NULL, '2026-01-17 08:36:52.328301+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "d9b71b6e-2f68-4132-b204-aa8b4b1916a0", "role": "admin_mechanic", "email": "emiliogala13@gmail.com", "full_name": "Emilio Perez", "workshop_name": "Taller Perez", "email_verified": true, "phone_verified": false}', NULL, '2026-01-17 08:27:37.148974+00', '2026-01-29 10:52:15.546457+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false) ON CONFLICT DO NOTHING;
INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES ('00000000-0000-0000-0000-000000000000', '40f338e1-54f7-4b46-9b6b-97c665d22285', 'authenticated', 'authenticated', 'antoniogallardos@yahoo.es', '$2a$10$Y.bYuWFPQjwUXjPGAKMG3eCXm7KQvgifhp7fuZfIxlVNJY.bYAqgK', '2025-10-26 15:37:40.003596+00', NULL, '', '2025-10-26 15:36:41.992899+00', '', NULL, '', '', NULL, '2025-10-26 15:37:40.010891+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "40f338e1-54f7-4b46-9b6b-97c665d22285", "role": "admin_mechanic", "email": "antoniogallardos@yahoo.es", "full_name": "Antonio Gallardo D\u00edaz ", "workshop_name": "Talleres Gallardo ", "email_verified": true, "phone_verified": false}', NULL, '2025-10-26 15:36:41.931811+00', '2025-10-26 17:31:53.182139+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false) ON CONFLICT DO NOTHING;
INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES ('00000000-0000-0000-0000-000000000000', 'e6681028-3cf5-4c31-92a8-9bb2938f3c55', 'authenticated', 'authenticated', 'dbftradingsng@gmail.com', '$2a$10$D64cAl14UjePTJammraVte7mBhA0xSFMKSNgi93hY1pRmOVRCPH7i', '2026-01-13 17:04:37.354873+00', NULL, '', '2026-01-13 17:03:38.818734+00', '', NULL, '', '', NULL, '2026-01-13 17:04:47.221706+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "e6681028-3cf5-4c31-92a8-9bb2938f3c55", "role": "admin_mechanic", "email": "dbftradingsng@gmail.com", "full_name": "Victor Ola", "workshop_name": "My Mechanical Workshop", "email_verified": true, "phone_verified": false}', NULL, '2026-01-13 17:03:38.731295+00', '2026-01-17 07:37:53.153834+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false) ON CONFLICT DO NOTHING;

-- auth.identities (origen: c:\migracion\auth_min.sql).
-- GoTrue exige una fila aqui con provider='email' para permitir el login con
-- email y contrasena; sin ellas los usuarios existen pero no pueden entrar.
-- Son 18 para 21 usuarios: los 3 con hash dummy no tienen identidad.

INSERT INTO auth.identities ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES ('11c7daf8-8a5e-4537-b6d1-3972c0abbd05', '11c7daf8-8a5e-4537-b6d1-3972c0abbd05', '{"sub": "11c7daf8-8a5e-4537-b6d1-3972c0abbd05", "email": "alexistomaselli@gmail.com", "workshop_name": "Taller Alexis", "email_verified": true, "phone_verified": false}', 'email', '2025-10-14 00:10:03.796872+00', '2025-10-14 00:10:03.796933+00', '2025-10-14 00:10:03.796933+00', 'cba4d786-301e-4f4b-b32e-dc6ed0ef8d73') ON CONFLICT DO NOTHING;
INSERT INTO auth.identities ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES ('64e2abb7-85b7-49b0-8e3d-007ee38a1cd8', '64e2abb7-85b7-49b0-8e3d-007ee38a1cd8', '{"sub": "64e2abb7-85b7-49b0-8e3d-007ee38a1cd8", "email": "dydsoftware1@gmail.com", "email_verified": true, "phone_verified": false}', 'email', '2025-10-15 21:27:01.543856+00', '2025-10-15 21:27:01.543911+00', '2025-10-15 21:27:01.543911+00', 'b40a5080-7551-4f86-be18-3df87e6ca6af') ON CONFLICT DO NOTHING;
INSERT INTO auth.identities ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES ('95eaba1c-5e43-4be5-8a48-e90e58b42cd0', '95eaba1c-5e43-4be5-8a48-e90e58b42cd0', '{"sub": "95eaba1c-5e43-4be5-8a48-e90e58b42cd0", "role": "admin_mechanic", "email": "hola@expertpericial.com", "full_name": "Juan Perez", "workshop_name": "Taller Extremadura", "email_verified": true, "phone_verified": false}', 'email', '2025-10-25 04:43:10.672673+00', '2025-10-25 04:43:10.67272+00', '2025-10-25 04:43:10.67272+00', 'cd1c8002-ad23-498b-bba3-2e7679a426a7') ON CONFLICT DO NOTHING;
INSERT INTO auth.identities ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES ('53107b25-ea1f-42b8-9ed7-f6d55d22127e', '53107b25-ea1f-42b8-9ed7-f6d55d22127e', '{"sub": "53107b25-ea1f-42b8-9ed7-f6d55d22127e", "role": "admin_mechanic", "email": "vmautomocion@hotmail.es", "full_name": "Juan Luis", "workshop_name": "VM Automocion ", "email_verified": false, "phone_verified": false}', 'email', '2025-10-25 12:34:32.167196+00', '2025-10-25 12:34:32.167262+00', '2025-10-25 12:34:32.167262+00', '8736fca1-1847-4e1a-b06a-282a91e4f70c') ON CONFLICT DO NOTHING;
INSERT INTO auth.identities ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES ('2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', '{"sub": "2ccb2fcc-314f-4efa-8d6a-fb44862a48e1", "role": "admin_mechanic", "email": "juanvelasco9888@gmail.com", "full_name": "Juan Velasco", "workshop_name": "Taller Velasco", "email_verified": true, "phone_verified": false}', 'email', '2025-10-22 20:07:29.218618+00', '2025-10-22 20:07:29.218667+00', '2025-10-22 20:07:29.218667+00', '29e43395-84b6-4ad4-9615-089f6fad63b2') ON CONFLICT DO NOTHING;
INSERT INTO auth.identities ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES ('485e7cd8-74c1-42e3-bd6b-1cde5ffaeb6b', '485e7cd8-74c1-42e3-bd6b-1cde5ffaeb6b', '{"sub": "485e7cd8-74c1-42e3-bd6b-1cde5ffaeb6b", "role": "admin_mechanic", "email": "info@expertpericial.com", "full_name": "juan", "workshop_name": "talle ubeda", "email_verified": true, "phone_verified": false}', 'email', '2025-10-24 11:58:21.223383+00', '2025-10-24 11:58:21.22399+00', '2025-10-24 11:58:21.22399+00', '7f61a746-d1e7-449b-8c8e-3ef37e5d0a7e') ON CONFLICT DO NOTHING;
INSERT INTO auth.identities ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES ('30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', '{"sub": "30e2ccb0-f8ad-45a7-b6dd-ed810c93f212", "email": "emilio@expertpericial.com", "email_verified": true, "phone_verified": false}', 'email', '2025-10-24 21:07:20.404264+00', '2025-10-24 21:07:20.404315+00', '2025-10-24 21:07:20.404315+00', 'eeaeb74d-7a25-4c90-ab67-9e63c1b70d0c') ON CONFLICT DO NOTHING;
INSERT INTO auth.identities ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES ('08cdb3f5-cd0a-4def-b883-7bae1f269d87', '08cdb3f5-cd0a-4def-b883-7bae1f269d87', '{"sub": "08cdb3f5-cd0a-4def-b883-7bae1f269d87", "role": "admin_mechanic", "email": "javaxtron@gmail.com", "full_name": "Javier fariña rodriguez", "workshop_name": "Chapicar", "email_verified": false, "phone_verified": false}', 'email', '2025-10-25 12:35:51.9251+00', '2025-10-25 12:35:51.925158+00', '2025-10-25 12:35:51.925158+00', '22479605-7d3f-458f-8573-d2a5e446b9cd') ON CONFLICT DO NOTHING;
INSERT INTO auth.identities ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES ('f38818fd-e683-4784-9f50-caa90e7f4256', 'f38818fd-e683-4784-9f50-caa90e7f4256', '{"sub": "f38818fd-e683-4784-9f50-caa90e7f4256", "role": "admin_mechanic", "email": "talleresribera@hotmail.es", "full_name": "Eva Vázquez Tortajada", "workshop_name": "TALLERES RIBERA C.B. ", "email_verified": false, "phone_verified": false}', 'email', '2025-10-25 12:37:47.355922+00', '2025-10-25 12:37:47.355969+00', '2025-10-25 12:37:47.355969+00', 'b0294b45-7b3b-4f5b-9ded-42b9ffa16329') ON CONFLICT DO NOTHING;
INSERT INTO auth.identities ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES ('8beae8ad-96f9-44aa-b799-b90b1691cd2b', '8beae8ad-96f9-44aa-b799-b90b1691cd2b', '{"sub": "8beae8ad-96f9-44aa-b799-b90b1691cd2b", "role": "admin_mechanic", "email": "tallerescidoncha@hotmail.com", "full_name": "Jose david ruiz", "workshop_name": "Talleres cidoncha", "email_verified": true, "phone_verified": false}', 'email', '2025-10-25 12:36:45.743056+00', '2025-10-25 12:36:45.743882+00', '2025-10-25 12:36:45.743882+00', '96a9a9e2-8092-4ea3-b488-81d512990b2c') ON CONFLICT DO NOTHING;
INSERT INTO auth.identities ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES ('b82e8e28-b1e6-468a-8ebc-a77ce99e6744', 'b82e8e28-b1e6-468a-8ebc-a77ce99e6744', '{"sub": "b82e8e28-b1e6-468a-8ebc-a77ce99e6744", "role": "admin_mechanic", "email": "tallerchapicar@gmail.com", "full_name": "Alberto Fariña Rodríguez ", "workshop_name": "Taller Chapicar ", "email_verified": false, "phone_verified": false}', 'email', '2025-10-25 12:39:18.965755+00', '2025-10-25 12:39:18.965813+00', '2025-10-25 12:39:18.965813+00', '1c985d2a-f743-4a59-81a9-a9048bc418ab') ON CONFLICT DO NOTHING;
INSERT INTO auth.identities ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES ('09a91c7c-419d-4f9e-b7d4-d2607559c146', '09a91c7c-419d-4f9e-b7d4-d2607559c146', '{"sub": "09a91c7c-419d-4f9e-b7d4-d2607559c146", "role": "admin_mechanic", "email": "sdsautomocion@gmail.com", "full_name": "Sergio Bautista Carrasco", "workshop_name": "SDS AUTOMOCION", "email_verified": true, "phone_verified": false}', 'email', '2025-10-26 07:42:51.902992+00', '2025-10-26 07:42:51.903053+00', '2025-10-26 07:42:51.903053+00', 'c6456d81-7357-4878-b853-1b13320d74d5') ON CONFLICT DO NOTHING;
INSERT INTO auth.identities ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES ('40f338e1-54f7-4b46-9b6b-97c665d22285', '40f338e1-54f7-4b46-9b6b-97c665d22285', '{"sub": "40f338e1-54f7-4b46-9b6b-97c665d22285", "role": "admin_mechanic", "email": "antoniogallardos@yahoo.es", "full_name": "Antonio Gallardo Díaz ", "workshop_name": "Talleres Gallardo ", "email_verified": true, "phone_verified": false}', 'email', '2025-10-26 15:36:41.973132+00', '2025-10-26 15:36:41.973184+00', '2025-10-26 15:36:41.973184+00', 'f3651386-6bc7-4239-a019-4dc6a6d2d1fb') ON CONFLICT DO NOTHING;
INSERT INTO auth.identities ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES ('7c97bc85-8ad5-4929-adcd-0326d183e374', '7c97bc85-8ad5-4929-adcd-0326d183e374', '{"sub": "7c97bc85-8ad5-4929-adcd-0326d183e374", "role": "admin_mechanic", "email": "higini@genaisapiens.com", "full_name": "Higini", "workshop_name": "Taller Higini", "email_verified": true, "phone_verified": false}', 'email', '2025-11-17 18:55:32.137859+00', '2025-11-17 18:55:32.140695+00', '2025-11-17 18:55:32.140695+00', '777f79c4-af2b-4c4c-925a-016ed8863e75') ON CONFLICT DO NOTHING;
INSERT INTO auth.identities ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES ('b0c73890-3fdf-49f2-b4af-29530c8ad59a', 'b0c73890-3fdf-49f2-b4af-29530c8ad59a', '{"sub": "b0c73890-3fdf-49f2-b4af-29530c8ad59a", "role": "admin_mechanic", "email": "victorafee@gmail.com", "full_name": "Victor Afe", "workshop_name": "My Mechanical Workshop", "email_verified": true, "phone_verified": false}', 'email', '2025-12-08 22:25:40.08235+00', '2025-12-08 22:25:40.082402+00', '2025-12-08 22:25:40.082402+00', 'da6e8b3f-5271-46ac-bfe7-fa4531835438') ON CONFLICT DO NOTHING;
INSERT INTO auth.identities ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES ('e6681028-3cf5-4c31-92a8-9bb2938f3c55', 'e6681028-3cf5-4c31-92a8-9bb2938f3c55', '{"sub": "e6681028-3cf5-4c31-92a8-9bb2938f3c55", "role": "admin_mechanic", "email": "dbftradingsng@gmail.com", "full_name": "Victor Ola", "workshop_name": "My Mechanical Workshop", "email_verified": true, "phone_verified": false}', 'email', '2026-01-13 17:03:38.793624+00', '2026-01-13 17:03:38.793683+00', '2026-01-13 17:03:38.793683+00', 'e29720d5-72ce-47fe-8ecb-979f996fc21e') ON CONFLICT DO NOTHING;
INSERT INTO auth.identities ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES ('d9b71b6e-2f68-4132-b204-aa8b4b1916a0', 'd9b71b6e-2f68-4132-b204-aa8b4b1916a0', '{"sub": "d9b71b6e-2f68-4132-b204-aa8b4b1916a0", "role": "admin_mechanic", "email": "emiliogala13@gmail.com", "full_name": "Emilio Perez", "workshop_name": "Taller Perez", "email_verified": true, "phone_verified": false}', 'email', '2026-01-17 08:27:37.198401+00', '2026-01-17 08:27:37.198457+00', '2026-01-17 08:27:37.198457+00', '4bfcc889-c287-427e-887a-5c5cf1abb595') ON CONFLICT DO NOTHING;
INSERT INTO auth.identities ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES ('e785f3eb-be32-4c2a-81fd-028031bb455b', 'e785f3eb-be32-4c2a-81fd-028031bb455b', '{"sub": "e785f3eb-be32-4c2a-81fd-028031bb455b", "role": "admin_mechanic", "email": "dyd.ialabs@gmail.com", "full_name": "Alexis Admin", "workshop_name": "Taller Admin", "email_verified": false, "phone_verified": false}', 'email', '2026-01-19 18:05:50.824955+00', '2026-01-19 18:05:50.825005+00', '2026-01-19 18:05:50.825005+00', '2fec87b8-15e6-4e3b-82f0-75ecf8fcda23') ON CONFLICT DO NOTHING;


-- Source: 20241010_auth_setup.sql
-- Crear tabla para perfiles de usuario con roles
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL PRIMARY KEY,
  email TEXT NOT NULL,
  role TEXT NOT NULL CHECK (role IN ('admin', 'admin_mechanic')),
  full_name TEXT,
  workshop_name TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL
);

-- Crear índice para búsqueda por email
CREATE INDEX IF NOT EXISTS profiles_email_idx ON public.profiles(email);

-- Función para manejar nuevos usuarios
CREATE OR REPLACE FUNCTION public.handle_new_user() 
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, role, full_name)
  VALUES (new.id, new.email, 'admin_mechanic', new.raw_user_meta_data->>'full_name');
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger para insertar automáticamente en profiles cuando se crea un usuario
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

-- Políticas de seguridad para la tabla profiles
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Política para que los usuarios solo puedan ver su propio perfil
CREATE POLICY "Users can view their own profile" 
  ON public.profiles 
  FOR SELECT 
  USING (auth.uid() = id);

-- Política para que los usuarios solo puedan actualizar su propio perfil
CREATE POLICY "Users can update their own profile" 
  ON public.profiles 
  FOR UPDATE 
  USING (auth.uid() = id);

-- Política para que los administradores puedan ver todos los perfiles
CREATE POLICY "Admins can view all profiles" 
  ON public.profiles 
  FOR SELECT 
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

-- Política para que los administradores puedan actualizar todos los perfiles
CREATE POLICY "Admins can update all profiles" 
  ON public.profiles 
  FOR UPDATE 
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

-- Nota: La creación del usuario administrador se hará manualmente a través de la interfaz de Supabase
-- o mediante código en el frontend después de configurar las tablas

-- Source: 20241011_create_admin_user.sql
-- Crear un usuario administrador usando la función de Supabase
-- Nota: En producción, este usuario debe crearse manualmente desde el dashboard
-- Esta migración solo crea el perfil si el usuario ya existe

-- Primero, intentamos crear el usuario usando la API de Supabase
-- Si falla, continuamos sin error
DO $$
DECLARE
  admin_id uuid;
BEGIN
  -- Intentar obtener el ID del usuario admin si ya existe
  SELECT id INTO admin_id FROM auth.users WHERE email = 'admin@valoraplus.com';
  
  -- Si no existe el usuario, crear un UUID temporal para el perfil
  -- El usuario real debe crearse desde el dashboard de Supabase
  IF admin_id IS NULL THEN
    admin_id := gen_random_uuid();
    
    -- Insertar un registro temporal en auth.users (esto puede fallar en Cloud)
    BEGIN
      INSERT INTO auth.users (
        id, 
        email, 
        encrypted_password, 
        email_confirmed_at, 
        created_at, 
        updated_at, 
        raw_app_meta_data, 
        raw_user_meta_data
      )
      VALUES (
        admin_id,
        'admin@valoraplus.com',
        '$2a$10$dummy.hash.for.development.only',  -- Hash dummy
        now(),
        now(),
        now(),
        '{"provider":"email","providers":["email"]}',
        '{}'
      );
    EXCEPTION WHEN OTHERS THEN
      -- Si falla, continuamos sin crear el usuario en auth.users
      NULL;
    END;
  END IF;
  
  -- Crear o actualizar el perfil en la tabla profiles
  INSERT INTO public.profiles (id, email, role, full_name, workshop_name)
  VALUES (
    admin_id,
    'admin@valoraplus.com',
    'admin',
    'Administrador Sistema',
    NULL
  ) ON CONFLICT (id) DO UPDATE SET 
    role = 'admin',
    email = 'admin@valoraplus.com',
    full_name = 'Administrador Sistema';
    
END $$;

-- Source: 20241012_create_workshops_table.sql
-- Create workshops table
CREATE TABLE public.workshops (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    address TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Add workshop_id to profiles table and remove workshop_name
ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS workshop_id UUID REFERENCES public.workshops(id) ON DELETE CASCADE,
ADD COLUMN IF NOT EXISTS phone TEXT;

-- Remove the old workshop_name column
ALTER TABLE public.profiles DROP COLUMN IF EXISTS workshop_name;

-- Create index for better performance
CREATE INDEX idx_profiles_workshop_id ON public.profiles(workshop_id);

-- Enable RLS on workshops table
ALTER TABLE public.workshops ENABLE ROW LEVEL SECURITY;

-- Create policies for workshops table
CREATE POLICY "Users can view their own workshop" ON public.workshops
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM public.profiles 
            WHERE profiles.workshop_id = workshops.id 
            AND profiles.id = auth.uid()
        )
    );

CREATE POLICY "Users can update their own workshop" ON public.workshops
    FOR UPDATE USING (
        EXISTS (
            SELECT 1 FROM public.profiles 
            WHERE profiles.workshop_id = workshops.id 
            AND profiles.id = auth.uid()
            AND profiles.role = 'admin_mechanic'
        )
    );

-- Allow admins to view and manage all workshops
CREATE POLICY "Admins can view all workshops" ON public.workshops
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM public.profiles 
            WHERE profiles.id = auth.uid() 
            AND profiles.role = 'admin'
        )
    );

CREATE POLICY "Admins can manage all workshops" ON public.workshops
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM public.profiles 
            WHERE profiles.id = auth.uid() 
            AND profiles.role = 'admin'
        )
    );

-- Function to handle workshop creation during user registration
CREATE OR REPLACE FUNCTION public.handle_workshop_registration(
    workshop_name TEXT,
    workshop_email TEXT,
    workshop_phone TEXT DEFAULT NULL
)
RETURNS UUID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    workshop_id UUID;
BEGIN
    -- Insert new workshop
    INSERT INTO public.workshops (name, email, phone)
    VALUES (workshop_name, workshop_email, workshop_phone)
    RETURNING id INTO workshop_id;
    
    RETURN workshop_id;
END;
$$;

-- Function to update user profile with workshop info
CREATE OR REPLACE FUNCTION public.complete_user_registration(
    user_id UUID,
    workshop_id UUID,
    user_phone TEXT DEFAULT NULL
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    -- Update user profile with workshop_id and phone
    UPDATE public.profiles 
    SET 
        workshop_id = complete_user_registration.workshop_id,
        phone = user_phone,
        updated_at = now()
    WHERE id = user_id;
END;
$$;

-- Grant necessary permissions
GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT ALL ON public.workshops TO authenticated;
GRANT EXECUTE ON FUNCTION public.handle_workshop_registration TO authenticated;
GRANT EXECUTE ON FUNCTION public.complete_user_registration TO authenticated;

-- Source: 20241013_fix_data_consistency.sql
-- Migración para corregir inconsistencias de datos y asegurar roles correctos
-- Fecha: 2024-10-13
-- Versión compatible con Supabase Cloud

-- 1. Primero, corregir el perfil del admin (eliminar workshop_name que ya no existe)
UPDATE public.profiles 
SET workshop_id = NULL 
WHERE email = 'admin@valoraplus.com' AND role = 'admin';

-- 2. Crear workshops de ejemplo (si no existen)
INSERT INTO public.workshops (id, name, email, phone, address) VALUES 
(
    '550e8400-e29b-41d4-a716-446655440000', 
    'Taller Mecánico Demo', 
    'demo@tallerdemo.com', 
    '612 345 678',
    'Calle Principal 123, Madrid'
),
(
    '550e8400-e29b-41d4-a716-446655440001', 
    'AutoReparaciones SL', 
    'info@autoreparaciones.com', 
    '634 567 890',
    'Avenida Industrial 45, Barcelona'
) ON CONFLICT (id) DO NOTHING;

-- 3. Crear perfiles para usuarios admin_mechanic de los workshops
-- Nota: Los usuarios reales deben crearse desde el dashboard de Supabase
DO $$
DECLARE
    workshop_demo_id uuid := '550e8400-e29b-41d4-a716-446655440000';
    workshop_auto_id uuid := '550e8400-e29b-41d4-a716-446655440001';
    user_demo_id uuid;
    user_auto_id uuid;
BEGIN
    -- Intentar obtener o crear ID para usuario demo
    SELECT id INTO user_demo_id FROM auth.users WHERE email = 'demo@tallerdemo.com';
    
    IF user_demo_id IS NULL THEN
        user_demo_id := gen_random_uuid();
        
        -- Intentar crear usuario demo (puede fallar en Cloud)
        BEGIN
            INSERT INTO auth.users (
                id, 
                instance_id,
                email, 
                encrypted_password, 
                email_confirmed_at, 
                created_at, 
                updated_at, 
                raw_app_meta_data, 
                raw_user_meta_data,
                aud,
                role
            ) VALUES (
                user_demo_id,
                '00000000-0000-0000-0000-000000000000',
                'demo@tallerdemo.com',
                '$2a$10$dummy.hash.for.development.only',  -- Hash dummy
                now(),
                now(),
                now(),
                '{"provider":"email","providers":["email"]}',
                '{"workshop_name":"Taller Mecánico Demo"}',
                'authenticated',
                'authenticated'
            );
        EXCEPTION WHEN OTHERS THEN
            -- Si falla, continuamos sin crear el usuario en auth.users
            NULL;
        END;
    END IF;

    -- Crear perfil para usuario demo
    INSERT INTO public.profiles (id, email, role, full_name, workshop_id, phone)
    VALUES (
        user_demo_id,
        'demo@tallerdemo.com',
        'admin_mechanic',
        'Juan Pérez',
        workshop_demo_id,
        '612 345 678'
    ) ON CONFLICT (id) DO UPDATE SET 
        role = 'admin_mechanic',
        workshop_id = workshop_demo_id,
        full_name = 'Juan Pérez',
        phone = '612 345 678';

    -- Intentar obtener o crear ID para usuario auto
    SELECT id INTO user_auto_id FROM auth.users WHERE email = 'info@autoreparaciones.com';
    
    IF user_auto_id IS NULL THEN
        user_auto_id := gen_random_uuid();
        
        -- Intentar crear usuario auto (puede fallar en Cloud)
        BEGIN
            INSERT INTO auth.users (
                id, 
                instance_id,
                email, 
                encrypted_password, 
                email_confirmed_at, 
                created_at, 
                updated_at, 
                raw_app_meta_data, 
                raw_user_meta_data,
                aud,
                role
            ) VALUES (
                user_auto_id,
                '00000000-0000-0000-0000-000000000000',
                'info@autoreparaciones.com',
                '$2a$10$dummy.hash.for.development.only',  -- Hash dummy
                now(),
                now(),
                now(),
                '{"provider":"email","providers":["email"]}',
                '{"workshop_name":"AutoReparaciones SL"}',
                'authenticated',
                'authenticated'
            );
        EXCEPTION WHEN OTHERS THEN
            -- Si falla, continuamos sin crear el usuario en auth.users
            NULL;
        END;
    END IF;

    -- Crear perfil para usuario auto
    INSERT INTO public.profiles (id, email, role, full_name, workshop_id, phone)
    VALUES (
        user_auto_id,
        'info@autoreparaciones.com',
        'admin_mechanic',
        'María García',
        workshop_auto_id,
        '634 567 890'
    ) ON CONFLICT (id) DO UPDATE SET 
        role = 'admin_mechanic',
        workshop_id = workshop_auto_id,
        full_name = 'María García',
        phone = '634 567 890';

END $$;

-- 3. Verificar que todo esté correcto
SELECT 'Verificación de datos:' as status;

-- Mostrar usuarios y sus roles
SELECT 
    u.email,
    p.role,
    p.full_name,
    w.name as workshop_name
FROM auth.users u
LEFT JOIN public.profiles p ON u.id = p.id
LEFT JOIN public.workshops w ON p.workshop_id = w.id
ORDER BY p.role, u.email;

-- Mostrar workshops y sus admin_mechanics
SELECT 
    w.name as workshop_name,
    w.email as workshop_email,
    p.full_name as admin_mechanic_name,
    u.email as admin_mechanic_email
FROM public.workshops w
LEFT JOIN public.profiles p ON w.id = p.workshop_id
LEFT JOIN auth.users u ON p.id = u.id
ORDER BY w.name;

-- Source: 20241014_make_workshop_email_optional.sql
-- Migración para hacer el email del workshop opcional
-- Fecha: 2024-10-14

-- 1. Modificar la tabla workshops para permitir email nulo
ALTER TABLE public.workshops 
ALTER COLUMN email DROP NOT NULL;

-- 2. Actualizar workshops existentes para separar conceptualmente el email del usuario del email del taller
-- Por ahora mantenemos los emails existentes, pero en el futuro los talleres podrán tener emails diferentes

-- 3. Comentario para clarificar el propósito de cada email
COMMENT ON COLUMN public.workshops.email IS 'Email comercial del taller (opcional). Puede ser diferente al email del usuario admin_mechanic.';
COMMENT ON COLUMN public.profiles.email IS 'Email del usuario para autenticación. Debe coincidir con auth.users.email.';

-- 4. Verificar la estructura actualizada
SELECT 
    'ESTRUCTURA ACTUALIZADA:' as status;

-- Mostrar la nueva estructura
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'workshops' 
    AND table_schema = 'public'
    AND column_name = 'email';

-- Source: 20241015_allow_admin_mechanic_create_workshop.sql
-- Allow admin_mechanic users to create workshops
-- Updated to avoid dependency on profiles table during registration
CREATE POLICY "Admin mechanics can create workshops v2" ON workshops
  FOR INSERT 
  WITH CHECK (
    auth.jwt() ->> 'email' IN (
      SELECT email FROM auth.users 
      WHERE raw_user_meta_data ->> 'role' = 'admin_mechanic'
    )
  );

-- Source: 20241016_fix_all_rls_policies.sql
-- Fix all RLS policies to avoid database access issues
-- This migration fixes infinite recursion and permission denied errors

-- 1. Fix profiles policies (remove infinite recursion)
DROP POLICY IF EXISTS "Admins can view all profiles" ON profiles;
DROP POLICY IF EXISTS "Admins can update all profiles" ON profiles;
DROP POLICY IF EXISTS "Admins can view all profiles v2" ON profiles;
DROP POLICY IF EXISTS "Admins can update all profiles v2" ON profiles;

-- Remove problematic function
DROP FUNCTION IF EXISTS is_admin_user();

-- Create new profiles policies that only use JWT
CREATE POLICY "Admins can view all profiles v3" ON profiles
  FOR SELECT USING (
    (auth.jwt() ->> 'user_metadata')::jsonb ->> 'role' = 'admin'
    OR 
    (auth.jwt() ->> 'raw_user_meta_data')::jsonb ->> 'role' = 'admin'
  );

CREATE POLICY "Admins can update all profiles v3" ON profiles
  FOR UPDATE USING (
    (auth.jwt() ->> 'user_metadata')::jsonb ->> 'role' = 'admin'
    OR 
    (auth.jwt() ->> 'raw_user_meta_data')::jsonb ->> 'role' = 'admin'
  );

-- 2. Fix workshops policies (remove auth.users access)
DROP POLICY IF EXISTS "Admin mechanics can create workshops" ON workshops;
DROP POLICY IF EXISTS "Admin mechanics can create workshops v2" ON workshops;

-- Create new workshop creation policy that only uses JWT
CREATE POLICY "Admin mechanics can create workshops v3" ON workshops
  FOR INSERT 
  WITH CHECK (
    (auth.jwt() ->> 'user_metadata')::jsonb ->> 'role' = 'admin_mechanic'
    OR 
    (auth.jwt() ->> 'raw_user_meta_data')::jsonb ->> 'role' = 'admin_mechanic'
  );

-- Source: 20241017_fix_profiles_infinite_recursion.sql
-- Fix infinite recursion in profiles RLS policies
-- Drop problematic policies that cause infinite recursion
DROP POLICY IF EXISTS "Admins can view all profiles" ON profiles;
DROP POLICY IF EXISTS "Admins can update all profiles" ON profiles;

-- Create a function that checks admin status without querying profiles table
CREATE OR REPLACE FUNCTION is_admin_user()
RETURNS BOOLEAN AS $$
BEGIN
  -- Verify if the authenticated user has admin role in auth.users metadata
  RETURN auth.jwt() ->> 'email' IN (
    SELECT email FROM auth.users 
    WHERE raw_user_meta_data ->> 'role' = 'admin'
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create new policies that don't cause recursion
CREATE POLICY "Admins can view all profiles v2" ON profiles
  FOR SELECT USING (is_admin_user());

CREATE POLICY "Admins can update all profiles v2" ON profiles
  FOR UPDATE USING (is_admin_user());

-- Source: 20241018_remove_workshops_insert_policy.sql
-- Remove INSERT policy from workshops table to allow registration
-- This replicates the behavior of the profiles table which has RLS enabled
-- but no INSERT policies, allowing creation during registration

-- Drop the INSERT policy that was causing registration failures
DROP POLICY IF EXISTS "Admin mechanics can create workshops v3" ON workshops;

-- Note: With RLS enabled but no INSERT policies, PostgreSQL allows
-- insertions by default, which is what we want for registration flow
-- Other policies (SELECT, UPDATE, DELETE) remain for proper access control

-- Source: 20241019_create_analysis_table.sql
-- Create analysis table for PDF analysis tracking
CREATE TABLE IF NOT EXISTS analysis (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    workshop_id UUID NOT NULL REFERENCES workshops(id) ON DELETE CASCADE,
    pdf_url TEXT,
    pdf_filename TEXT,
    status TEXT NOT NULL DEFAULT 'processing' CHECK (status IN ('processing', 'pending_verification', 'pending_costs', 'completed', 'failed')),
    analysis_month DATE NOT NULL DEFAULT DATE_TRUNC('month', CURRENT_DATE),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index for efficient queries
CREATE INDEX idx_analysis_workshop_id ON analysis(workshop_id);
CREATE INDEX idx_analysis_status ON analysis(status);
CREATE INDEX idx_analysis_month ON analysis(analysis_month);

-- Enable RLS
ALTER TABLE analysis ENABLE ROW LEVEL SECURITY;

-- Create RLS policies
CREATE POLICY "Users can view their own workshop analysis" ON analysis
    FOR SELECT USING (
        workshop_id IN (
            SELECT id FROM workshops 
            WHERE id IN (
                SELECT workshop_id FROM profiles 
                WHERE id = auth.uid()
            )
        )
    );

CREATE POLICY "Users can insert analysis for their workshop" ON analysis
    FOR INSERT WITH CHECK (
        workshop_id IN (
            SELECT id FROM workshops 
            WHERE id IN (
                SELECT workshop_id FROM profiles 
                WHERE id = auth.uid()
            )
        )
    );

CREATE POLICY "Users can update their own workshop analysis" ON analysis
    FOR UPDATE USING (
        workshop_id IN (
            SELECT id FROM workshops 
            WHERE id IN (
                SELECT workshop_id FROM profiles 
                WHERE id = auth.uid()
            )
        )
    );

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_analysis_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for updated_at
CREATE TRIGGER trigger_analysis_updated_at
    BEFORE UPDATE ON analysis
    FOR EACH ROW
    EXECUTE FUNCTION update_analysis_updated_at();

-- Create storage bucket for PDFs if it doesn't exist
INSERT INTO storage.buckets (id, name)
VALUES ('analysis-pdfs', 'analysis-pdfs')
ON CONFLICT (id) DO NOTHING;

-- Create storage policies for PDFs
CREATE POLICY "Users can upload PDFs for their workshop" ON storage.objects
    FOR INSERT WITH CHECK (
        bucket_id = 'analysis-pdfs' AND
        auth.uid() IS NOT NULL
    );

CREATE POLICY "Users can view PDFs for their workshop" ON storage.objects
    FOR SELECT USING (
        bucket_id = 'analysis-pdfs' AND
        auth.uid() IS NOT NULL
    );

CREATE POLICY "Users can delete PDFs for their workshop" ON storage.objects
    FOR DELETE USING (
        bucket_id = 'analysis-pdfs' AND
        auth.uid() IS NOT NULL
    );

-- Source: 20241020_create_extracted_data_tables.sql
-- Create tables for storing extracted data from n8n analysis

-- Create function to update updated_at column
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Table for vehicle metadata extracted from PDF
CREATE TABLE vehicle_data (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  analysis_id UUID NOT NULL REFERENCES analysis(id) ON DELETE CASCADE,
  license_plate TEXT,
  vin TEXT,
  manufacturer TEXT,
  model TEXT,
  internal_reference TEXT,
  system TEXT, -- e.g., "AUDA"
  hourly_price DECIMAL(10,2),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table for insurance amounts extracted from PDF
CREATE TABLE insurance_amounts (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  analysis_id UUID NOT NULL REFERENCES analysis(id) ON DELETE CASCADE,
  -- Totales de repuestos
  total_spare_parts_eur DECIMAL(10,2),
  -- Mano de obra carrocería
  bodywork_labor_ut DECIMAL(10,2),
  bodywork_labor_eur DECIMAL(10,2),
  -- Mano de obra pintura
  painting_labor_ut DECIMAL(10,2),
  painting_labor_eur DECIMAL(10,2),
  -- Material de pintura
  paint_material_eur DECIMAL(10,2),
  -- Totales calculados
  net_subtotal DECIMAL(10,2),
  iva_amount DECIMAL(10,2),
  total_with_iva DECIMAL(10,2),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX idx_vehicle_data_analysis_id ON vehicle_data(analysis_id);
CREATE INDEX idx_insurance_amounts_analysis_id ON insurance_amounts(analysis_id);

-- Create updated_at triggers
CREATE TRIGGER update_vehicle_data_updated_at
  BEFORE UPDATE ON vehicle_data
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_insurance_amounts_updated_at
  BEFORE UPDATE ON insurance_amounts
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Enable RLS
ALTER TABLE vehicle_data ENABLE ROW LEVEL SECURITY;
ALTER TABLE insurance_amounts ENABLE ROW LEVEL SECURITY;

-- RLS Policies for vehicle_data
CREATE POLICY "Users can view their own vehicle data" ON vehicle_data
  FOR SELECT USING (
    analysis_id IN (
      SELECT id FROM analysis WHERE workshop_id = auth.uid()
    )
  );

CREATE POLICY "Users can insert their own vehicle data" ON vehicle_data
  FOR INSERT WITH CHECK (
    analysis_id IN (
      SELECT id FROM analysis WHERE workshop_id = auth.uid()
    )
  );

CREATE POLICY "Users can update their own vehicle data" ON vehicle_data
  FOR UPDATE USING (
    analysis_id IN (
      SELECT id FROM analysis WHERE workshop_id = auth.uid()
    )
  );

-- RLS Policies for insurance_amounts
CREATE POLICY "Users can view their own insurance amounts" ON insurance_amounts
  FOR SELECT USING (
    analysis_id IN (
      SELECT id FROM analysis WHERE workshop_id = auth.uid()
    )
  );

CREATE POLICY "Users can insert their own insurance amounts" ON insurance_amounts
  FOR INSERT WITH CHECK (
    analysis_id IN (
      SELECT id FROM analysis WHERE workshop_id = auth.uid()
    )
  );

CREATE POLICY "Users can update their own insurance amounts" ON insurance_amounts
  FOR UPDATE USING (
    analysis_id IN (
      SELECT id FROM analysis WHERE workshop_id = auth.uid()
    )
  );

-- Source: 20241021_create_workshop_costs_table.sql
-- Create workshop_costs table to store actual workshop costs
CREATE TABLE workshop_costs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    analysis_id UUID NOT NULL REFERENCES analysis(id) ON DELETE CASCADE,
    
    -- Spare parts costs
    spare_parts_purchase_cost DECIMAL(10,2),
    
    -- Bodywork labor costs
    bodywork_actual_hours DECIMAL(8,2),
    bodywork_hourly_cost DECIMAL(8,2),
    
    -- Painting labor costs
    painting_actual_hours DECIMAL(8,2),
    painting_hourly_cost DECIMAL(8,2),
    
    -- Other costs
    painting_consumables_cost DECIMAL(10,2),
    subcontractor_costs DECIMAL(10,2),
    other_costs DECIMAL(10,2),
    
    -- Notes
    notes TEXT,
    
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create RLS policies
ALTER TABLE workshop_costs ENABLE ROW LEVEL SECURITY;

-- Policy for workshop users to manage their own costs
CREATE POLICY "workshop_costs_workshop_policy" ON workshop_costs
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM analysis a
            JOIN profiles p ON p.workshop_id = a.workshop_id
            WHERE a.id = workshop_costs.analysis_id
            AND p.id = auth.uid()
        )
    );

-- Policy for admin users to view all costs
CREATE POLICY "workshop_costs_admin_policy" ON workshop_costs
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE profiles.id = auth.uid()
            AND profiles.role = 'admin'
        )
    );

-- Create updated_at trigger
CREATE TRIGGER update_workshop_costs_updated_at
    BEFORE UPDATE ON workshop_costs
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Source: 20241022_fix_user_role_from_metadata.sql
-- Fix handle_new_user function to use role from user metadata
CREATE OR REPLACE FUNCTION public.handle_new_user() 
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, role, full_name)
  VALUES (
    new.id, 
    new.email, 
    COALESCE(new.raw_user_meta_data->>'role', 'admin_mechanic'), -- Use role from metadata, default to admin_mechanic
    new.raw_user_meta_data->>'full_name'
  );
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Source: 20241023_disable_workshops_rls.sql
-- Disable RLS on workshops table to allow registration
ALTER TABLE public.workshops DISABLE ROW LEVEL SECURITY;

-- Drop all existing policies on workshops table
DROP POLICY IF EXISTS "Users can view their own workshop" ON public.workshops;
DROP POLICY IF EXISTS "Users can update their own workshop" ON public.workshops;
DROP POLICY IF EXISTS "Admins can view all workshops" ON public.workshops;
DROP POLICY IF EXISTS "Admins can manage all workshops" ON public.workshops;
DROP POLICY IF EXISTS "Admin mechanics can create workshops v2" ON public.workshops;
DROP POLICY IF EXISTS "Admin mechanics can create workshops v3" ON public.workshops;

-- Fix handle_new_user function to properly handle full_name from signup data
CREATE OR REPLACE FUNCTION public.handle_new_user() 
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, role, full_name)
  VALUES (
    new.id, 
    new.email, 
    COALESCE(new.raw_user_meta_data->>'role', 'admin_mechanic'),
    COALESCE(new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'workshop_name', 'Usuario')
  );
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Source: 20241024_setup_storage.sql
-- Create documents bucket for PDF uploads
INSERT INTO storage.buckets (id, name)
VALUES (
  'documents',
  'documents'
) ON CONFLICT (id) DO NOTHING;

-- Source: 20241025_create_system_settings.sql
-- Crear tabla para configuraciones del sistema
CREATE TABLE IF NOT EXISTS system_settings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  setting_key VARCHAR(100) UNIQUE NOT NULL,
  setting_value JSONB NOT NULL,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_by UUID REFERENCES auth.users(id)
);

-- Crear índices para optimizar consultas
CREATE INDEX IF NOT EXISTS idx_system_settings_key ON system_settings(setting_key);
CREATE INDEX IF NOT EXISTS idx_system_settings_updated_at ON system_settings(updated_at);

-- Insertar configuraciones iniciales del sistema
INSERT INTO system_settings (setting_key, setting_value, description) VALUES
  ('monthly_free_analyses_limit', '{"value": 3}', 'Límite de análisis gratuitos por mes para usuarios admin_mechanic'),
  ('additional_analysis_price', '{"value": 25.00, "currency": "EUR"}', 'Precio por análisis adicional después del límite gratuito'),
  ('billing_enabled', '{"value": true}', 'Si está habilitada la facturación por análisis adicionales'),
  ('stripe_enabled', '{"value": false}', 'Si está habilitada la integración con Stripe'),
  ('company_info', '{"name": "Valora Plus", "tax_id": "", "address": "", "email": ""}', 'Información de la empresa para facturación')
ON CONFLICT (setting_key) DO NOTHING;

-- Función para obtener configuración del sistema
CREATE OR REPLACE FUNCTION get_system_setting(setting_name TEXT)
RETURNS JSONB AS $$
BEGIN
  RETURN (SELECT setting_value FROM system_settings WHERE setting_key = setting_name);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función para actualizar configuración del sistema (solo admins)
CREATE OR REPLACE FUNCTION update_system_setting(setting_name TEXT, new_value JSONB)
RETURNS BOOLEAN AS $$
DECLARE
  user_role TEXT;
BEGIN
  -- Verificar que el usuario es admin
  SELECT role INTO user_role FROM profiles WHERE id = auth.uid();
  
  IF user_role != 'admin' THEN
    RAISE EXCEPTION 'Solo los administradores pueden modificar configuraciones del sistema';
  END IF;
  
  -- Actualizar la configuración
  UPDATE system_settings 
  SET setting_value = new_value, 
      updated_at = NOW(), 
      updated_by = auth.uid()
  WHERE setting_key = setting_name;
  
  RETURN FOUND;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Políticas RLS para system_settings
ALTER TABLE system_settings ENABLE ROW LEVEL SECURITY;

-- Los admins pueden ver y modificar todas las configuraciones
CREATE POLICY "Admins can manage system settings" ON system_settings
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = auth.uid() 
      AND profiles.role = 'admin'
    )
  );

-- Los usuarios pueden ver configuraciones públicas (solo lectura)
CREATE POLICY "Users can view public settings" ON system_settings
  FOR SELECT USING (
    setting_key IN (
      'monthly_free_analyses_limit',
      'additional_analysis_price',
      'billing_enabled'
    )
  );

-- Trigger para actualizar updated_at
CREATE OR REPLACE FUNCTION update_system_settings_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_system_settings_updated_at
  BEFORE UPDATE ON system_settings
  FOR EACH ROW
  EXECUTE FUNCTION update_system_settings_updated_at();

-- Source: 20241026_create_user_monthly_usage.sql
-- Crear tabla para el seguimiento del uso mensual de análisis por usuario
CREATE TABLE IF NOT EXISTS user_monthly_usage (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  year INTEGER NOT NULL,
  month INTEGER NOT NULL,
  analyses_count INTEGER DEFAULT 0,
  free_analyses_used INTEGER DEFAULT 0,
  paid_analyses_count INTEGER DEFAULT 0,
  total_amount_due DECIMAL(10,2) DEFAULT 0,
  payment_status VARCHAR(20) DEFAULT 'pending', -- pending, paid, overdue
  stripe_payment_intent_id TEXT, -- ID del payment intent de Stripe
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id, year, month)
);

-- Crear índices para optimizar consultas
CREATE INDEX IF NOT EXISTS idx_user_monthly_usage_user_id ON user_monthly_usage(user_id);
CREATE INDEX IF NOT EXISTS idx_user_monthly_usage_year_month ON user_monthly_usage(year, month);
CREATE INDEX IF NOT EXISTS idx_user_monthly_usage_payment_status ON user_monthly_usage(payment_status);
CREATE INDEX IF NOT EXISTS idx_user_monthly_usage_stripe_payment ON user_monthly_usage(stripe_payment_intent_id);

-- Función para obtener o crear el registro de uso mensual del usuario actual
CREATE OR REPLACE FUNCTION get_or_create_monthly_usage(target_year INTEGER DEFAULT NULL, target_month INTEGER DEFAULT NULL)
RETURNS user_monthly_usage AS $$
DECLARE
  current_year INTEGER := COALESCE(target_year, EXTRACT(YEAR FROM NOW()));
  current_month INTEGER := COALESCE(target_month, EXTRACT(MONTH FROM NOW()));
  usage_record user_monthly_usage;
BEGIN
  -- Intentar obtener el registro existente
  SELECT * INTO usage_record 
  FROM user_monthly_usage 
  WHERE user_id = auth.uid() 
    AND year = current_year 
    AND month = current_month;
  
  -- Si no existe, crearlo
  IF NOT FOUND THEN
    INSERT INTO user_monthly_usage (user_id, year, month)
    VALUES (auth.uid(), current_year, current_month)
    RETURNING * INTO usage_record;
  END IF;
  
  RETURN usage_record;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función para incrementar el conteo de análisis
CREATE OR REPLACE FUNCTION increment_analysis_count()
RETURNS JSONB AS $$
DECLARE
  current_year INTEGER := EXTRACT(YEAR FROM NOW());
  current_month INTEGER := EXTRACT(MONTH FROM NOW());
  usage_record user_monthly_usage;
  free_limit INTEGER;
  additional_price DECIMAL(10,2);
  is_free_analysis BOOLEAN := FALSE;
  amount_to_charge DECIMAL(10,2) := 0;
  current_total_analyses INTEGER := 0;
  user_workshop_id UUID;
BEGIN
  -- Obtener configuraciones del sistema
  SELECT (get_system_setting('monthly_free_analyses_limit')->>'value')::INTEGER INTO free_limit;
  SELECT (get_system_setting('additional_analysis_price')->>'value')::DECIMAL INTO additional_price;
  
  -- Obtener el workshop_id del usuario actual
  SELECT workshop_id INTO user_workshop_id 
  FROM profiles 
  WHERE id = auth.uid();
  
  -- Contar análisis reales del mes actual (antes de crear el nuevo)
  SELECT COUNT(*) INTO current_total_analyses
  FROM analysis 
  WHERE workshop_id = user_workshop_id
    AND EXTRACT(YEAR FROM created_at) = current_year
    AND EXTRACT(MONTH FROM created_at) = current_month;
  
  -- Determinar si este análisis es gratuito o de pago basado en el conteo real
  IF current_total_analyses < free_limit THEN
    is_free_analysis := TRUE;
  ELSE
    amount_to_charge := additional_price;
  END IF;
  
  -- Obtener o crear registro de uso mensual
  SELECT * INTO usage_record FROM get_or_create_monthly_usage(current_year, current_month);
  
  -- Solo actualizar el total_amount_due si hay cargo
  IF amount_to_charge > 0 THEN
    UPDATE user_monthly_usage 
    SET 
      total_amount_due = total_amount_due + amount_to_charge,
      updated_at = NOW()
    WHERE user_id = auth.uid() 
      AND year = current_year 
      AND month = current_month;
  END IF;
  
  -- Retornar información sobre el análisis
  RETURN jsonb_build_object(
    'is_free', is_free_analysis,
    'amount_charged', amount_to_charge,
    'total_analyses', current_total_analyses + 1,
    'free_analyses_used', LEAST(current_total_analyses + 1, free_limit),
    'free_analyses_limit', free_limit
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función para obtener el uso mensual actual del usuario
CREATE OR REPLACE FUNCTION get_current_monthly_usage()
RETURNS JSONB AS $$
DECLARE
  current_year INTEGER := EXTRACT(YEAR FROM NOW());
  current_month INTEGER := EXTRACT(MONTH FROM NOW());
  usage_record user_monthly_usage;
  free_limit INTEGER;
  actual_total_analyses INTEGER := 0;
  actual_free_analyses INTEGER := 0;
  actual_paid_analyses INTEGER := 0;
  user_workshop_id UUID;
BEGIN
  -- Obtener configuraciones del sistema
  SELECT (get_system_setting('monthly_free_analyses_limit')->>'value')::INTEGER INTO free_limit;
  
  -- Obtener el workshop_id del usuario actual
  SELECT workshop_id INTO user_workshop_id 
  FROM profiles 
  WHERE id = auth.uid();
  
  -- Contar análisis reales del mes actual desde la tabla analysis
  SELECT COUNT(*) INTO actual_total_analyses
  FROM analysis 
  WHERE workshop_id = user_workshop_id
    AND EXTRACT(YEAR FROM created_at) = current_year
    AND EXTRACT(MONTH FROM created_at) = current_month;
  
  -- Calcular análisis gratuitos y de pago basado en el límite
  actual_free_analyses := LEAST(actual_total_analyses, free_limit);
  actual_paid_analyses := GREATEST(0, actual_total_analyses - free_limit);
  
  -- Obtener registro de uso mensual (crear si no existe) para obtener payment_status y total_amount_due
  SELECT * INTO usage_record FROM get_or_create_monthly_usage(current_year, current_month);
  
  RETURN jsonb_build_object(
    'total_analyses', actual_total_analyses,
    'free_analyses_used', actual_free_analyses,
    'paid_analyses_count', actual_paid_analyses,
    'free_analyses_limit', free_limit,
    'remaining_free_analyses', GREATEST(0, free_limit - actual_free_analyses),
    'total_amount_due', usage_record.total_amount_due,
    'payment_status', usage_record.payment_status,
    'year', current_year,
    'month', current_month
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función para marcar un pago como completado
CREATE OR REPLACE FUNCTION mark_payment_completed(stripe_payment_intent_id TEXT)
RETURNS BOOLEAN AS $$
BEGIN
  UPDATE user_monthly_usage 
  SET 
    payment_status = 'paid',
    updated_at = NOW()
  WHERE stripe_payment_intent_id = stripe_payment_intent_id;
  
  RETURN FOUND;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Políticas RLS para user_monthly_usage
ALTER TABLE user_monthly_usage ENABLE ROW LEVEL SECURITY;

-- Los usuarios pueden ver y modificar solo sus propios registros
CREATE POLICY "Users can manage their own monthly usage" ON user_monthly_usage
  FOR ALL USING (user_id = auth.uid());

-- Los admins pueden ver todos los registros
CREATE POLICY "Admins can view all monthly usage" ON user_monthly_usage
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = auth.uid() 
      AND profiles.role = 'admin'
    )
  );

-- Trigger para actualizar updated_at
CREATE OR REPLACE FUNCTION update_user_monthly_usage_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_user_monthly_usage_updated_at
  BEFORE UPDATE ON user_monthly_usage
  FOR EACH ROW
  EXECUTE FUNCTION update_user_monthly_usage_updated_at();

-- Constraint para validar el estado de pago
ALTER TABLE user_monthly_usage 
ADD CONSTRAINT check_payment_status 
CHECK (payment_status IN ('pending', 'paid', 'overdue', 'failed'));

-- Constraint para validar mes y año
ALTER TABLE user_monthly_usage 
ADD CONSTRAINT check_month_range 
CHECK (month >= 1 AND month <= 12);

ALTER TABLE user_monthly_usage 
ADD CONSTRAINT check_year_range 
CHECK (year >= 2024 AND year <= 2100);

-- Source: 20241027_setup_stripe_integration.sql
-- Crear tabla para almacenar información de pagos de Stripe
CREATE TABLE IF NOT EXISTS stripe_payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  payment_intent_id TEXT UNIQUE NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  currency VARCHAR(3) DEFAULT 'EUR',
  status VARCHAR(50) NOT NULL, -- requires_payment_method, requires_confirmation, requires_action, processing, requires_capture, canceled, succeeded
  description TEXT,
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crear índices para optimizar consultas
CREATE INDEX IF NOT EXISTS idx_stripe_payments_user_id ON stripe_payments(user_id);
CREATE INDEX IF NOT EXISTS idx_stripe_payments_payment_intent ON stripe_payments(payment_intent_id);
CREATE INDEX IF NOT EXISTS idx_stripe_payments_status ON stripe_payments(status);

-- Función para crear un payment intent de Stripe (simulada - se implementará con Edge Functions)
CREATE OR REPLACE FUNCTION create_stripe_payment_intent(
  amount_cents INTEGER,
  currency_code TEXT DEFAULT 'eur',
  description_text TEXT DEFAULT NULL
)
RETURNS JSONB AS $$
DECLARE
  payment_record stripe_payments;
  mock_payment_intent_id TEXT;
BEGIN
  -- Generar un ID simulado para el payment intent (en producción esto vendrá de Stripe)
  mock_payment_intent_id := 'pi_mock_' || gen_random_uuid()::TEXT;
  
  -- Insertar registro de pago
  INSERT INTO stripe_payments (
    user_id, 
    payment_intent_id, 
    amount, 
    currency, 
    status, 
    description,
    metadata
  ) VALUES (
    auth.uid(),
    mock_payment_intent_id,
    amount_cents / 100.0,
    currency_code,
    'requires_payment_method',
    description_text,
    jsonb_build_object(
      'user_id', auth.uid(),
      'created_by', 'system',
      'type', 'additional_analysis'
    )
  ) RETURNING * INTO payment_record;
  
  -- Retornar información del payment intent
  RETURN jsonb_build_object(
    'payment_intent_id', payment_record.payment_intent_id,
    'amount', payment_record.amount,
    'currency', payment_record.currency,
    'status', payment_record.status,
    'client_secret', 'pi_mock_secret_' || gen_random_uuid()::TEXT -- En producción esto vendrá de Stripe
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función para actualizar el estado de un payment intent
CREATE OR REPLACE FUNCTION update_stripe_payment_status(
  payment_intent_id_param TEXT,
  new_status TEXT
)
RETURNS BOOLEAN AS $$
BEGIN
  UPDATE stripe_payments 
  SET 
    status = new_status,
    updated_at = NOW()
  WHERE payment_intent_id = payment_intent_id_param;
  
  -- Si el pago fue exitoso, actualizar el estado en user_monthly_usage
  IF new_status = 'succeeded' THEN
    PERFORM mark_payment_completed(payment_intent_id_param);
  END IF;
  
  RETURN FOUND;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función para procesar un análisis con verificación de pago
CREATE OR REPLACE FUNCTION process_analysis_with_payment_check()
RETURNS JSONB AS $$
DECLARE
  usage_info JSONB;
  payment_info JSONB;
  billing_enabled BOOLEAN;
BEGIN
  -- Verificar si la facturación está habilitada
  SELECT (get_system_setting('billing_enabled')->>'value')::BOOLEAN INTO billing_enabled;
  
  -- Incrementar el conteo de análisis
  SELECT increment_analysis_count() INTO usage_info;
  
  -- Si no es gratuito y la facturación está habilitada, crear payment intent
  IF NOT (usage_info->>'is_free')::BOOLEAN AND billing_enabled THEN
    SELECT create_stripe_payment_intent(
      ((usage_info->>'amount_charged')::DECIMAL * 100)::INTEGER, -- Convertir a centavos
      'eur',
      'Análisis adicional - ' || TO_CHAR(NOW(), 'MM/YYYY')
    ) INTO payment_info;
    
    -- Actualizar el registro de uso mensual con el payment intent ID
    UPDATE user_monthly_usage 
    SET stripe_payment_intent_id = payment_info->>'payment_intent_id'
    WHERE user_id = auth.uid() 
      AND year = EXTRACT(YEAR FROM NOW())
      AND month = EXTRACT(MONTH FROM NOW());
  END IF;
  
  -- Retornar información completa
  RETURN jsonb_build_object(
    'usage_info', usage_info,
    'payment_info', COALESCE(payment_info, '{}'::JSONB),
    'requires_payment', NOT (usage_info->>'is_free')::BOOLEAN AND billing_enabled
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función para obtener historial de pagos del usuario
CREATE OR REPLACE FUNCTION get_user_payment_history()
RETURNS JSONB AS $$
DECLARE
  payments JSONB;
BEGIN
  SELECT jsonb_agg(
    jsonb_build_object(
      'id', sp.id,
      'amount', sp.amount,
      'currency', sp.currency,
      'status', sp.status,
      'description', sp.description,
      'created_at', sp.created_at,
      'month_year', TO_CHAR(sp.created_at, 'MM/YYYY')
    ) ORDER BY sp.created_at DESC
  ) INTO payments
  FROM stripe_payments sp
  WHERE sp.user_id = auth.uid();
  
  RETURN COALESCE(payments, '[]'::JSONB);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Políticas RLS para stripe_payments
ALTER TABLE stripe_payments ENABLE ROW LEVEL SECURITY;

-- Los usuarios pueden ver solo sus propios pagos
CREATE POLICY "Users can view their own payments" ON stripe_payments
  FOR SELECT USING (user_id = auth.uid());

-- Los admins pueden ver todos los pagos
CREATE POLICY "Admins can view all payments" ON stripe_payments
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = auth.uid() 
      AND profiles.role = 'admin'
    )
  );

-- Solo el sistema puede insertar/actualizar pagos (a través de funciones SECURITY DEFINER)
CREATE POLICY "System can manage payments" ON stripe_payments
  FOR ALL USING (FALSE); -- Bloquear acceso directo, solo a través de funciones

-- Trigger para actualizar updated_at
CREATE OR REPLACE FUNCTION update_stripe_payments_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_stripe_payments_updated_at
  BEFORE UPDATE ON stripe_payments
  FOR EACH ROW
  EXECUTE FUNCTION update_stripe_payments_updated_at();

-- Agregar configuraciones adicionales para Stripe
INSERT INTO system_settings (setting_key, setting_value, description) VALUES
  ('stripe_publishable_key', '{"value": ""}', 'Clave pública de Stripe para el frontend'),
  ('stripe_webhook_secret', '{"value": ""}', 'Secret para validar webhooks de Stripe'),
  ('payment_success_redirect', '{"value": "/my-account?payment=success"}', 'URL de redirección después de pago exitoso'),
  ('payment_cancel_redirect', '{"value": "/my-account?payment=cancelled"}', 'URL de redirección después de cancelar pago')
ON CONFLICT (setting_key) DO NOTHING;

-- Source: 20241028_simplify_user_monthly_usage.sql
-- Simplificar la tabla user_monthly_usage eliminando campos redundantes
-- Ahora que contamos directamente desde la tabla analysis, estos campos ya no son necesarios

-- Eliminar columnas redundantes que ahora se calculan dinámicamente
ALTER TABLE user_monthly_usage 
DROP COLUMN IF EXISTS analyses_count,
DROP COLUMN IF EXISTS free_analyses_used,
DROP COLUMN IF EXISTS paid_analyses_count;

-- Actualizar la función get_or_create_monthly_usage para no inicializar estos campos
CREATE OR REPLACE FUNCTION get_or_create_monthly_usage(target_year INTEGER DEFAULT NULL, target_month INTEGER DEFAULT NULL)
RETURNS user_monthly_usage AS $$
DECLARE
  current_year INTEGER := COALESCE(target_year, EXTRACT(YEAR FROM NOW()));
  current_month INTEGER := COALESCE(target_month, EXTRACT(MONTH FROM NOW()));
  usage_record user_monthly_usage;
BEGIN
  -- Intentar obtener el registro existente
  SELECT * INTO usage_record 
  FROM user_monthly_usage 
  WHERE user_id = auth.uid() 
    AND year = current_year 
    AND month = current_month;
  
  -- Si no existe, crear uno nuevo
  IF NOT FOUND THEN
    INSERT INTO user_monthly_usage (
      user_id, 
      year, 
      month,
      total_amount_due,
      payment_status
    ) VALUES (
      auth.uid(), 
      current_year, 
      current_month,
      0,
      'pending'
    ) RETURNING * INTO usage_record;
  END IF;
  
  RETURN usage_record;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Comentario explicativo sobre el nuevo enfoque
COMMENT ON TABLE user_monthly_usage IS 'Tabla simplificada para seguimiento de pagos mensuales. Los conteos de análisis se calculan dinámicamente desde la tabla analysis.';
COMMENT ON COLUMN user_monthly_usage.total_amount_due IS 'Monto total adeudado por análisis de pago del mes';
COMMENT ON COLUMN user_monthly_usage.payment_status IS 'Estado del pago: pending, paid, overdue';
COMMENT ON COLUMN user_monthly_usage.stripe_payment_intent_id IS 'ID del payment intent de Stripe para este mes';

-- Source: 20241029_create_payments_table.sql
-- Crear tabla payments mejorada para registrar todas las transacciones de Stripe
CREATE TABLE IF NOT EXISTS payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  workshop_id UUID REFERENCES workshops(id) NOT NULL,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  
  -- Datos de Stripe
  stripe_payment_intent_id TEXT UNIQUE NOT NULL,
  stripe_session_id TEXT,
  stripe_customer_id TEXT,
  
  -- Detalles del pago
  amount_cents INTEGER NOT NULL, -- en centavos
  currency TEXT DEFAULT 'EUR' NOT NULL,
  status TEXT NOT NULL, -- 'pending', 'succeeded', 'failed', 'canceled'
  
  -- Contexto del pago
  analysis_month TEXT NOT NULL, -- formato 'YYYY-MM'
  analyses_purchased INTEGER DEFAULT 1 NOT NULL, -- cuántos análisis se compraron
  unit_price_cents INTEGER NOT NULL, -- precio por análisis en centavos
  
  -- Metadatos
  payment_method TEXT, -- 'card', 'sepa_debit', etc.
  stripe_fee_cents INTEGER, -- comisión de Stripe
  net_amount_cents INTEGER, -- cantidad neta recibida
  description TEXT,
  
  -- Timestamps
  created_at TIMESTAMPTZ DEFAULT NOW(),
  paid_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Crear índices para optimizar consultas
CREATE INDEX IF NOT EXISTS idx_payments_workshop_id ON payments(workshop_id);
CREATE INDEX IF NOT EXISTS idx_payments_user_id ON payments(user_id);
CREATE INDEX IF NOT EXISTS idx_payments_stripe_payment_intent ON payments(stripe_payment_intent_id);
CREATE INDEX IF NOT EXISTS idx_payments_status ON payments(status);
CREATE INDEX IF NOT EXISTS idx_payments_analysis_month ON payments(analysis_month);

-- Políticas RLS para payments
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;

-- Los usuarios pueden ver solo los pagos de su workshop
CREATE POLICY "Users can view their workshop payments" ON payments
  FOR SELECT USING (
    workshop_id IN (
      SELECT workshop_id FROM profiles WHERE id = auth.uid()
    )
  );

-- Los admins pueden ver todos los pagos
CREATE POLICY "Admins can view all payments" ON payments
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = auth.uid() 
      AND profiles.role = 'admin'
    )
  );

-- Solo el sistema puede insertar/actualizar pagos (a través de funciones SECURITY DEFINER)
CREATE POLICY "System can manage payments" ON payments
  FOR ALL USING (FALSE); -- Bloquear acceso directo, solo a través de funciones

-- Trigger para actualizar updated_at
CREATE OR REPLACE FUNCTION update_payments_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_payments_updated_at
  BEFORE UPDATE ON payments
  FOR EACH ROW
  EXECUTE FUNCTION update_payments_updated_at();

-- Función para crear un registro de pago
CREATE OR REPLACE FUNCTION create_payment_record(
  workshop_id_param UUID,
  stripe_payment_intent_id_param TEXT,
  stripe_session_id_param TEXT,
  amount_cents_param INTEGER,
  currency_param TEXT DEFAULT 'EUR',
  analysis_month_param TEXT DEFAULT NULL,
  description_param TEXT DEFAULT NULL
)
RETURNS UUID AS $$
DECLARE
  payment_id UUID;
  current_month TEXT;
BEGIN
  -- Usar el mes actual si no se proporciona
  current_month := COALESCE(analysis_month_param, TO_CHAR(NOW(), 'YYYY-MM'));
  
  -- Insertar registro de pago
  INSERT INTO payments (
    workshop_id,
    user_id,
    stripe_payment_intent_id,
    stripe_session_id,
    amount_cents,
    currency,
    status,
    analysis_month,
    analyses_purchased,
    unit_price_cents,
    description
  ) VALUES (
    workshop_id_param,
    auth.uid(),
    stripe_payment_intent_id_param,
    stripe_session_id_param,
    amount_cents_param,
    currency_param,
    'pending',
    current_month,
    1, -- Por defecto 1 análisis
    amount_cents_param, -- Por ahora el precio unitario es igual al total
    description_param
  ) RETURNING id INTO payment_id;
  
  RETURN payment_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función para actualizar el estado de un pago
CREATE OR REPLACE FUNCTION update_payment_status(
  stripe_payment_intent_id_param TEXT,
  new_status TEXT,
  payment_method_param TEXT DEFAULT NULL,
  stripe_fee_cents_param INTEGER DEFAULT NULL
)
RETURNS BOOLEAN AS $$
DECLARE
  payment_record payments;
BEGIN
  -- Actualizar el estado del pago
  UPDATE payments 
  SET 
    status = new_status,
    payment_method = COALESCE(payment_method_param, payment_method),
    stripe_fee_cents = COALESCE(stripe_fee_cents_param, stripe_fee_cents),
    net_amount_cents = CASE 
      WHEN stripe_fee_cents_param IS NOT NULL 
      THEN amount_cents - stripe_fee_cents_param 
      ELSE net_amount_cents 
    END,
    paid_at = CASE WHEN new_status = 'succeeded' THEN NOW() ELSE paid_at END,
    updated_at = NOW()
  WHERE stripe_payment_intent_id = stripe_payment_intent_id_param
  RETURNING * INTO payment_record;
  
  -- Si el pago fue exitoso, actualizar el estado en user_monthly_usage
  IF new_status = 'succeeded' AND payment_record.id IS NOT NULL THEN
    PERFORM mark_payment_completed(stripe_payment_intent_id_param);
  END IF;
  
  RETURN FOUND;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función para obtener historial de pagos de un workshop
CREATE OR REPLACE FUNCTION get_workshop_payment_history(workshop_id_param UUID DEFAULT NULL)
RETURNS JSONB AS $$
DECLARE
  target_workshop_id UUID;
  payments_data JSONB;
BEGIN
  -- Si no se proporciona workshop_id, usar el del usuario actual
  IF workshop_id_param IS NULL THEN
    SELECT workshop_id INTO target_workshop_id
    FROM profiles 
    WHERE id = auth.uid();
  ELSE
    target_workshop_id := workshop_id_param;
  END IF;
  
  -- Verificar que el usuario tenga acceso al workshop
  IF NOT EXISTS (
    SELECT 1 FROM profiles 
    WHERE id = auth.uid() 
    AND (workshop_id = target_workshop_id OR role = 'admin')
  ) THEN
    RAISE EXCEPTION 'Access denied to workshop payments';
  END IF;
  
  SELECT jsonb_agg(
    jsonb_build_object(
      'id', p.id,
      'amount_cents', p.amount_cents,
      'amount_euros', ROUND(p.amount_cents / 100.0, 2),
      'currency', p.currency,
      'status', p.status,
      'description', p.description,
      'analysis_month', p.analysis_month,
      'analyses_purchased', p.analyses_purchased,
      'payment_method', p.payment_method,
      'created_at', p.created_at,
      'paid_at', p.paid_at
    ) ORDER BY p.created_at DESC
  ) INTO payments_data
  FROM payments p
  WHERE p.workshop_id = target_workshop_id;
  
  RETURN COALESCE(payments_data, '[]'::JSONB);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función para obtener estadísticas de pagos para admin
CREATE OR REPLACE FUNCTION get_payment_statistics()
RETURNS JSONB AS $$
DECLARE
  stats JSONB;
BEGIN
  -- Verificar que el usuario sea admin
  IF NOT EXISTS (
    SELECT 1 FROM profiles 
    WHERE id = auth.uid() AND role = 'admin'
  ) THEN
    RAISE EXCEPTION 'Access denied - admin only';
  END IF;
  
  SELECT jsonb_build_object(
    'total_revenue_cents', COALESCE(SUM(CASE WHEN status = 'succeeded' THEN amount_cents ELSE 0 END), 0),
    'total_revenue_euros', ROUND(COALESCE(SUM(CASE WHEN status = 'succeeded' THEN amount_cents ELSE 0 END), 0) / 100.0, 2),
    'total_payments', COUNT(*),
    'successful_payments', COUNT(*) FILTER (WHERE status = 'succeeded'),
    'pending_payments', COUNT(*) FILTER (WHERE status = 'pending'),
    'failed_payments', COUNT(*) FILTER (WHERE status IN ('failed', 'canceled')),
    'current_month_revenue_cents', COALESCE(SUM(CASE 
      WHEN status = 'succeeded' AND analysis_month = TO_CHAR(NOW(), 'YYYY-MM') 
      THEN amount_cents ELSE 0 END), 0),
    'workshops_with_payments', COUNT(DISTINCT workshop_id) FILTER (WHERE status = 'succeeded')
  ) INTO stats
  FROM payments;
  
  RETURN stats;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Source: 20241030_fix_workshops_insert_policy.sql
-- Fix workshops INSERT policy to allow registration
-- The issue: RLS is enabled but there's no INSERT policy, preventing workshop creation

-- Add INSERT policy to allow authenticated users to create workshops
-- This is needed for the registration flow where new users create their workshop
CREATE POLICY "Allow authenticated users to create workshops" ON public.workshops
FOR INSERT 
TO authenticated
WITH CHECK (true);

-- Also ensure we have a proper SELECT policy for workshop owners
-- This allows users to see their own workshop after creation
DROP POLICY IF EXISTS "Users can view their own workshop" ON public.workshops;
CREATE POLICY "Users can view their own workshop" ON public.workshops
FOR SELECT 
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM public.profiles 
    WHERE profiles.workshop_id = workshops.id 
    AND profiles.id = auth.uid()
  )
);

-- Note: This maintains security while allowing the registration flow to work
-- Users can create workshops, but can only see their own workshop
-- Admins can still see all workshops via existing admin policies

-- Source: 20241031_allow_profile_insert.sql
-- Allow users to insert their own profile (needed for UPSERT during registration)
-- This is safe because users can only insert their own profile (auth.uid() = id)

CREATE POLICY "Users can insert their own profile" 
  ON public.profiles 
  FOR INSERT 
  WITH CHECK (auth.uid() = id);

-- Source: 20241101_fix_workshop_costs_rls.sql
-- Fix workshop_costs RLS policies to allow proper access
-- The issue is that the current policies are too restrictive and block SELECT queries
-- even when no data exists, which is normal for new analyses

-- Drop existing policies
DROP POLICY IF EXISTS "workshop_costs_workshop_policy" ON workshop_costs;
DROP POLICY IF EXISTS "workshop_costs_admin_policy" ON workshop_costs;

-- Create separate policies for different operations
-- Policy for SELECT operations - allows users to query their workshop's costs (even if empty)
CREATE POLICY "workshop_costs_select_policy" ON workshop_costs
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM analysis a
            JOIN profiles p ON p.workshop_id = a.workshop_id
            WHERE a.id = workshop_costs.analysis_id
            AND p.id = auth.uid()
        )
        OR
        EXISTS (
            SELECT 1 FROM profiles
            WHERE profiles.id = auth.uid()
            AND profiles.role = 'admin'
        )
    );

-- Policy for INSERT operations - allows users to create costs for their workshop's analyses
CREATE POLICY "workshop_costs_insert_policy" ON workshop_costs
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM analysis a
            JOIN profiles p ON p.workshop_id = a.workshop_id
            WHERE a.id = workshop_costs.analysis_id
            AND p.id = auth.uid()
        )
        OR
        EXISTS (
            SELECT 1 FROM profiles
            WHERE profiles.id = auth.uid()
            AND profiles.role = 'admin'
        )
    );

-- Policy for UPDATE operations - allows users to update costs for their workshop's analyses
CREATE POLICY "workshop_costs_update_policy" ON workshop_costs
    FOR UPDATE USING (
        EXISTS (
            SELECT 1 FROM analysis a
            JOIN profiles p ON p.workshop_id = a.workshop_id
            WHERE a.id = workshop_costs.analysis_id
            AND p.id = auth.uid()
        )
        OR
        EXISTS (
            SELECT 1 FROM profiles
            WHERE profiles.id = auth.uid()
            AND profiles.role = 'admin'
        )
    );

-- Policy for DELETE operations - allows users to delete costs for their workshop's analyses
CREATE POLICY "workshop_costs_delete_policy" ON workshop_costs
    FOR DELETE USING (
        EXISTS (
            SELECT 1 FROM analysis a
            JOIN profiles p ON p.workshop_id = a.workshop_id
            WHERE a.id = workshop_costs.analysis_id
            AND p.id = auth.uid()
        )
        OR
        EXISTS (
            SELECT 1 FROM profiles
            WHERE profiles.id = auth.uid()
            AND profiles.role = 'admin'
        )
    );

-- Source: 20241220_add_converted_hours_fields.sql
-- Add converted hours fields and unit metadata to insurance_amounts table
-- This migration adds support for storing converted hours alongside original UT values

ALTER TABLE insurance_amounts 
ADD COLUMN IF NOT EXISTS bodywork_labor_hours DECIMAL(10,2),
ADD COLUMN IF NOT EXISTS painting_labor_hours DECIMAL(10,2),
ADD COLUMN IF NOT EXISTS detected_units TEXT CHECK (detected_units IN ('UT', 'HORAS', 'MIXTO'));

-- Add comments to explain the new fields
COMMENT ON COLUMN insurance_amounts.bodywork_labor_hours IS 'Mano de obra chapa convertida a horas (10 UT = 1 hora)';
COMMENT ON COLUMN insurance_amounts.painting_labor_hours IS 'Mano de obra pintura convertida a horas (10 UT = 1 hora)';
COMMENT ON COLUMN insurance_amounts.detected_units IS 'Tipo de unidades detectadas en el PDF: UT, HORAS o MIXTO';

-- Update existing records to convert UT to hours (assuming existing data is in UT)
-- Only update if the hours fields are null and UT fields have values
UPDATE insurance_amounts 
SET 
  bodywork_labor_hours = ROUND(bodywork_labor_ut / 10.0, 2),
  painting_labor_hours = ROUND(painting_labor_ut / 10.0, 2),
  detected_units = 'UT'
WHERE 
  bodywork_labor_hours IS NULL 
  AND painting_labor_hours IS NULL 
  AND (bodywork_labor_ut IS NOT NULL OR painting_labor_ut IS NOT NULL);

-- Source: 20241220_add_hourly_prices_to_insurance_amounts.sql
-- Agregar campos de precios por hora a la tabla insurance_amounts
ALTER TABLE insurance_amounts 
ADD COLUMN IF NOT EXISTS bodywork_hourly_price DECIMAL(10,2),
ADD COLUMN IF NOT EXISTS painting_hourly_price DECIMAL(10,2),
ADD COLUMN IF NOT EXISTS bodywork_labor_hours DECIMAL(10,2),
ADD COLUMN IF NOT EXISTS painting_labor_hours DECIMAL(10,2),
ADD COLUMN IF NOT EXISTS iva_percentage DECIMAL(5,2);

-- Agregar comentarios para documentar los nuevos campos
COMMENT ON COLUMN insurance_amounts.bodywork_hourly_price IS 'Precio por hora de mano de obra de chapa';
COMMENT ON COLUMN insurance_amounts.painting_hourly_price IS 'Precio por hora de mano de obra de pintura';
COMMENT ON COLUMN insurance_amounts.bodywork_labor_hours IS 'Horas de mano de obra de chapa';
COMMENT ON COLUMN insurance_amounts.painting_labor_hours IS 'Horas de mano de obra de pintura';
COMMENT ON COLUMN insurance_amounts.iva_percentage IS 'Porcentaje de IVA aplicado';

-- Source: 20241224_disable_workshop_costs_rls.sql
-- Disable Row Level Security for workshop_costs table temporarily
-- This is a temporary fix to resolve authentication issues with the workshop costs page

ALTER TABLE public.workshop_costs DISABLE ROW LEVEL SECURITY;

-- Add a comment explaining this is temporary
COMMENT ON TABLE public.workshop_costs IS 'RLS temporarily disabled due to session authentication issues. Should be re-enabled once auth flow is fixed.';

-- Source: 20241225_update_payment_status_with_session_id.sql
-- Actualizar la función update_payment_status para incluir stripe_session_id_param
CREATE OR REPLACE FUNCTION update_payment_status(
  stripe_payment_intent_id_param TEXT,
  new_status TEXT,
  payment_method_param TEXT DEFAULT NULL,
  stripe_fee_cents_param INTEGER DEFAULT NULL,
  stripe_session_id_param TEXT DEFAULT NULL
)
RETURNS BOOLEAN AS $$
DECLARE
  payment_record payments;
BEGIN
  -- Actualizar el estado del pago
  UPDATE payments 
  SET 
    status = new_status,
    payment_method = COALESCE(payment_method_param, payment_method),
    stripe_fee_cents = COALESCE(stripe_fee_cents_param, stripe_fee_cents),
    stripe_session_id = COALESCE(stripe_session_id_param, stripe_session_id),
    net_amount_cents = CASE 
      WHEN stripe_fee_cents_param IS NOT NULL 
      THEN amount_cents - stripe_fee_cents_param 
      ELSE net_amount_cents 
    END,
    paid_at = CASE WHEN new_status = 'succeeded' THEN NOW() ELSE paid_at END,
    updated_at = NOW()
  WHERE stripe_payment_intent_id = stripe_payment_intent_id_param
  RETURNING * INTO payment_record;
  
  -- Si el pago fue exitoso, actualizar el estado en user_monthly_usage
  IF new_status = 'succeeded' AND payment_record.id IS NOT NULL THEN
    PERFORM mark_payment_completed(stripe_payment_intent_id_param);
  END IF;
  
  RETURN FOUND;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Source: 20241226_fix_payments_rls_policies.sql
-- Arreglar las políticas RLS para permitir que las funciones SECURITY DEFINER accedan a payments

-- Eliminar la política restrictiva actual
DROP POLICY IF EXISTS "System can manage payments" ON payments;

-- Crear una política que permita acceso a las funciones del sistema
-- Las funciones SECURITY DEFINER se ejecutan con el rol del propietario de la función
CREATE POLICY "System functions can manage payments" ON payments
  FOR ALL USING (
    -- Permitir acceso si no hay usuario autenticado (webhooks) 
    -- O si es una función del sistema (SECURITY DEFINER)
    auth.uid() IS NULL 
    OR 
    -- Permitir si es el propietario de la función (postgres/service_role)
    current_setting('role', true) = 'service_role'
    OR
    -- Permitir si es una función SECURITY DEFINER ejecutándose
    current_setting('request.jwt.claims', true)::json->>'role' = 'service_role'
  );

-- También crear una política específica para webhooks anónimos
CREATE POLICY "Anonymous webhooks can manage payments" ON payments
  FOR ALL USING (
    -- Permitir si no hay usuario autenticado (caso de webhooks)
    auth.uid() IS NULL
  );

-- Source: 20250121_add_customer_id_to_payment_record.sql
-- Add stripe_customer_id parameter to create_payment_record function

CREATE OR REPLACE FUNCTION create_payment_record(
  workshop_id_param UUID,
  user_id_param UUID,
  stripe_payment_intent_id_param TEXT,
  stripe_session_id_param TEXT,
  stripe_customer_id_param TEXT,
  amount_cents_param INTEGER,
  currency_param TEXT DEFAULT 'EUR',
  analysis_month_param TEXT DEFAULT NULL,
  description_param TEXT DEFAULT NULL
)
RETURNS UUID AS $$
DECLARE
  payment_id UUID;
  current_month TEXT;
BEGIN
  -- Usar el mes actual si no se proporciona
  current_month := COALESCE(analysis_month_param, TO_CHAR(NOW(), 'YYYY-MM'));
  
  -- Insertar registro de pago
  INSERT INTO payments (
    workshop_id,
    user_id,
    stripe_payment_intent_id,
    stripe_session_id,
    stripe_customer_id,
    amount_cents,
    currency,
    status,
    analysis_month,
    analyses_purchased,
    unit_price_cents,
    description
  ) VALUES (
    workshop_id_param,
    user_id_param,
    stripe_payment_intent_id_param,
    stripe_session_id_param,
    stripe_customer_id_param,
    amount_cents_param,
    currency_param,
    'pending',
    current_month,
    1, -- Por defecto 1 análisis
    amount_cents_param, -- Por ahora el precio unitario es igual al total
    description_param
  ) RETURNING id INTO payment_id;
  
  RETURN payment_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Source: 20250121_fix_create_payment_record_customer_id.sql
-- Fix create_payment_record function to accept stripe_customer_id parameter
-- This solves the issue where the function call fails due to parameter mismatch

CREATE OR REPLACE FUNCTION create_payment_record(
  workshop_id_param UUID,
  user_id_param UUID,
  stripe_payment_intent_id_param TEXT,
  stripe_session_id_param TEXT,
  amount_cents_param INTEGER,
  stripe_customer_id_param TEXT DEFAULT NULL,
  currency_param TEXT DEFAULT 'EUR',
  analysis_month_param TEXT DEFAULT NULL,
  description_param TEXT DEFAULT NULL
)
RETURNS UUID AS $$
DECLARE
  payment_id UUID;
  current_month TEXT;
BEGIN
  -- Usar el mes actual si no se proporciona
  current_month := COALESCE(analysis_month_param, TO_CHAR(NOW(), 'YYYY-MM'));
  
  -- Insertar registro de pago
  INSERT INTO payments (
    workshop_id,
    user_id,
    stripe_payment_intent_id,
    stripe_session_id,
    stripe_customer_id,
    amount_cents,
    currency,
    status,
    analysis_month,
    analyses_purchased,
    unit_price_cents,
    description
  ) VALUES (
    workshop_id_param,
    user_id_param,
    stripe_payment_intent_id_param,
    stripe_session_id_param,
    stripe_customer_id_param,
    amount_cents_param,
    currency_param,
    'pending',
    current_month,
    1, -- Por defecto 1 análisis
    amount_cents_param, -- Por ahora el precio unitario es igual al total
    description_param
  ) RETURNING id INTO payment_id;
  
  RETURN payment_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Source: 20250121_fix_create_payment_record_user_id.sql
-- Fix create_payment_record function to accept user_id parameter
-- This solves the issue where webhooks fail because auth.uid() returns null

CREATE OR REPLACE FUNCTION create_payment_record(
  workshop_id_param UUID,
  user_id_param UUID,
  stripe_payment_intent_id_param TEXT,
  stripe_session_id_param TEXT,
  amount_cents_param INTEGER,
  currency_param TEXT DEFAULT 'EUR',
  analysis_month_param TEXT DEFAULT NULL,
  description_param TEXT DEFAULT NULL
)
RETURNS UUID AS $$
DECLARE
  payment_id UUID;
  current_month TEXT;
BEGIN
  -- Usar el mes actual si no se proporciona
  current_month := COALESCE(analysis_month_param, TO_CHAR(NOW(), 'YYYY-MM'));
  
  -- Insertar registro de pago
  INSERT INTO payments (
    workshop_id,
    user_id,
    stripe_payment_intent_id,
    stripe_session_id,
    amount_cents,
    currency,
    status,
    analysis_month,
    analyses_purchased,
    unit_price_cents,
    description
  ) VALUES (
    workshop_id_param,
    user_id_param, -- Usar el parámetro en lugar de auth.uid()
    stripe_payment_intent_id_param,
    stripe_session_id_param,
    amount_cents_param,
    currency_param,
    'pending',
    current_month,
    1, -- Por defecto 1 análisis
    amount_cents_param, -- Por ahora el precio unitario es igual al total
    description_param
  ) RETURNING id INTO payment_id;
  
  RETURN payment_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Source: 20250121_fix_update_payment_status_overload.sql
-- Solucionar conflicto de sobrecarga de funciones update_payment_status
-- Eliminar todas las versiones anteriores y mantener solo la más completa

-- Eliminar versión original (4 parámetros)
DROP FUNCTION IF EXISTS update_payment_status(
  stripe_payment_intent_id_param TEXT,
  new_status TEXT,
  payment_method_param TEXT,
  stripe_fee_cents_param INTEGER
);

-- Eliminar versión con session_id (5 parámetros)
DROP FUNCTION IF EXISTS update_payment_status(
  stripe_payment_intent_id_param TEXT,
  new_status TEXT,
  payment_method_param TEXT,
  stripe_fee_cents_param INTEGER,
  stripe_session_id_param TEXT
);

-- Recrear la función final con todos los parámetros (6 parámetros)
-- Esta es la versión más completa que debe mantenerse
CREATE OR REPLACE FUNCTION update_payment_status(
  stripe_payment_intent_id_param TEXT,
  new_status TEXT,
  payment_method_param TEXT DEFAULT NULL,
  stripe_fee_cents_param INTEGER DEFAULT NULL,
  stripe_session_id_param TEXT DEFAULT NULL,
  stripe_customer_id_param TEXT DEFAULT NULL
)
RETURNS BOOLEAN AS $$
DECLARE
  payment_record payments;
BEGIN
  -- Actualizar el estado del pago
  UPDATE payments 
  SET 
    status = new_status,
    payment_method = COALESCE(payment_method_param, payment_method),
    stripe_fee_cents = COALESCE(stripe_fee_cents_param, stripe_fee_cents),
    stripe_session_id = COALESCE(stripe_session_id_param, stripe_session_id),
    stripe_customer_id = COALESCE(stripe_customer_id_param, stripe_customer_id),
    net_amount_cents = CASE 
      WHEN stripe_fee_cents_param IS NOT NULL 
      THEN amount_cents - stripe_fee_cents_param 
      ELSE net_amount_cents 
    END,
    paid_at = CASE WHEN new_status = 'succeeded' THEN NOW() ELSE paid_at END,
    updated_at = NOW()
  WHERE stripe_payment_intent_id = stripe_payment_intent_id_param
  RETURNING * INTO payment_record;
  
  -- Si el pago fue exitoso, actualizar el estado en user_monthly_usage
  IF new_status = 'succeeded' AND payment_record.id IS NOT NULL THEN
    PERFORM mark_payment_completed(stripe_payment_intent_id_param);
  END IF;
  
  RETURN FOUND;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Source: 20250121_update_payment_status_with_customer_id.sql
-- Actualizar la función update_payment_status para incluir stripe_customer_id_param
CREATE OR REPLACE FUNCTION update_payment_status(
  stripe_payment_intent_id_param TEXT,
  new_status TEXT,
  payment_method_param TEXT DEFAULT NULL,
  stripe_fee_cents_param INTEGER DEFAULT NULL,
  stripe_session_id_param TEXT DEFAULT NULL,
  stripe_customer_id_param TEXT DEFAULT NULL
)
RETURNS BOOLEAN AS $$
DECLARE
  payment_record payments;
BEGIN
  -- Actualizar el estado del pago
  UPDATE payments 
  SET 
    status = new_status,
    payment_method = COALESCE(payment_method_param, payment_method),
    stripe_fee_cents = COALESCE(stripe_fee_cents_param, stripe_fee_cents),
    stripe_session_id = COALESCE(stripe_session_id_param, stripe_session_id),
    stripe_customer_id = COALESCE(stripe_customer_id_param, stripe_customer_id),
    net_amount_cents = CASE 
      WHEN stripe_fee_cents_param IS NOT NULL 
      THEN amount_cents - stripe_fee_cents_param 
      ELSE net_amount_cents 
    END,
    paid_at = CASE WHEN new_status = 'succeeded' THEN NOW() ELSE paid_at END,
    updated_at = NOW()
  WHERE stripe_payment_intent_id = stripe_payment_intent_id_param
  RETURNING * INTO payment_record;
  
  -- Si el pago fue exitoso, actualizar el estado en user_monthly_usage
  IF new_status = 'succeeded' AND payment_record.id IS NOT NULL THEN
    PERFORM mark_payment_completed(stripe_payment_intent_id_param);
  END IF;
  
  RETURN FOUND;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Source: 20250121_webhook_simplification.sql
-- Webhook Simplification Migration
-- This migration documents the webhook simplification to avoid duplicate payment processing

-- Verify that the update_payment_status function exists with the correct signature
-- This should already be created by the previous migration
DO $$
BEGIN
  -- Check if the function exists with the correct parameters
  IF NOT EXISTS (
    SELECT 1 FROM pg_proc p
    JOIN pg_namespace n ON p.pronamespace = n.oid
    WHERE n.nspname = 'public'
    AND p.proname = 'update_payment_status'
    AND p.pronargs = 6  -- 6 parameters
  ) THEN
    RAISE EXCEPTION 'update_payment_status function with 6 parameters not found. Please run the fix_update_payment_status_overload migration first.';
  END IF;
  
  RAISE NOTICE 'update_payment_status function verified successfully';
END $$;

-- Add a comment to document the webhook simplification
COMMENT ON FUNCTION update_payment_status(TEXT, TEXT, TEXT, INTEGER, TEXT, TEXT) IS 
'Updated function to handle payment status updates from simplified webhook. 
Webhook now only processes:
- checkout.session.completed (for successful payments)
- checkout.session.expired (for canceled payments) 
- payment_intent.payment_failed (for failed payments)
Removed duplicate events: payment_intent.succeeded and charge.succeeded to avoid conflicts.';

-- Verify that create_payment_record function exists with customer_id parameter
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_proc p
    JOIN pg_namespace n ON p.pronamespace = n.oid
    WHERE n.nspname = 'public'
    AND p.proname = 'create_payment_record'
    AND p.pronargs = 9  -- 9 parameters including stripe_customer_id_param
  ) THEN
    RAISE EXCEPTION 'create_payment_record function with customer_id parameter not found. Please run the add_customer_id_to_payment_record migration first.';
  END IF;
  
  RAISE NOTICE 'create_payment_record function verified successfully';
END $$;

-- Source: 20250122_create_user_paid_analyses_balance.sql
-- Create user_paid_analyses_balance table for persistent paid analyses
CREATE TABLE user_paid_analyses_balance (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    remaining_analyses INTEGER NOT NULL DEFAULT 0 CHECK (remaining_analyses >= 0),
    total_purchased INTEGER NOT NULL DEFAULT 0 CHECK (total_purchased >= 0),
    total_used INTEGER NOT NULL DEFAULT 0 CHECK (total_used >= 0),
    package_type VARCHAR(50) DEFAULT 'individual' CHECK (package_type IN ('individual', 'package_5', 'package_10', 'package_20')),
    purchase_history JSONB DEFAULT '[]'::jsonb,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create unique index on user_id (one record per user)
CREATE UNIQUE INDEX idx_user_paid_analyses_balance_user_id ON user_paid_analyses_balance(user_id);

-- Create index on remaining_analyses for quick lookups
CREATE INDEX idx_user_paid_analyses_balance_remaining ON user_paid_analyses_balance(remaining_analyses);

-- Add RLS policies
ALTER TABLE user_paid_analyses_balance ENABLE ROW LEVEL SECURITY;

-- Policy: Users can only see their own balance
CREATE POLICY "Users can view own paid analyses balance" ON user_paid_analyses_balance
    FOR SELECT USING (auth.uid() = user_id);

-- Policy: Users can update their own balance (for consuming analyses)
CREATE POLICY "Users can update own paid analyses balance" ON user_paid_analyses_balance
    FOR UPDATE USING (auth.uid() = user_id);

-- Policy: System can insert new balances (for new users or purchases)
CREATE POLICY "System can insert paid analyses balance" ON user_paid_analyses_balance
    FOR INSERT WITH CHECK (true);

-- Function to get or create user paid analyses balance
CREATE OR REPLACE FUNCTION get_or_create_paid_analyses_balance(p_user_id UUID)
RETURNS user_paid_analyses_balance AS $$
DECLARE
    balance_record user_paid_analyses_balance;
BEGIN
    -- Try to get existing balance
    SELECT * INTO balance_record
    FROM user_paid_analyses_balance
    WHERE user_id = p_user_id;
    
    -- If no balance exists, create one
    IF NOT FOUND THEN
        INSERT INTO user_paid_analyses_balance (user_id)
        VALUES (p_user_id)
        RETURNING * INTO balance_record;
    END IF;
    
    RETURN balance_record;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to add paid analyses to user balance
CREATE OR REPLACE FUNCTION add_paid_analyses(
    p_user_id UUID,
    p_analyses_count INTEGER,
    p_package_type VARCHAR(50) DEFAULT 'individual',
    p_stripe_payment_intent_id TEXT DEFAULT NULL,
    p_amount_paid DECIMAL DEFAULT NULL
)
RETURNS user_paid_analyses_balance AS $$
DECLARE
    balance_record user_paid_analyses_balance;
    purchase_entry JSONB;
BEGIN
    -- Validate input
    IF p_analyses_count <= 0 THEN
        RAISE EXCEPTION 'Analyses count must be positive';
    END IF;
    
    -- Get or create balance record
    SELECT * INTO balance_record FROM get_or_create_paid_analyses_balance(p_user_id);
    
    -- Create purchase history entry
    purchase_entry := jsonb_build_object(
        'date', NOW(),
        'analyses_count', p_analyses_count,
        'package_type', p_package_type,
        'stripe_payment_intent_id', p_stripe_payment_intent_id,
        'amount_paid', p_amount_paid
    );
    
    -- Update balance
    UPDATE user_paid_analyses_balance
    SET 
        remaining_analyses = remaining_analyses + p_analyses_count,
        total_purchased = total_purchased + p_analyses_count,
        package_type = p_package_type,
        purchase_history = purchase_history || purchase_entry,
        updated_at = NOW()
    WHERE user_id = p_user_id
    RETURNING * INTO balance_record;
    
    RETURN balance_record;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to consume a paid analysis
CREATE OR REPLACE FUNCTION consume_paid_analysis(p_user_id UUID)
RETURNS BOOLEAN AS $$
DECLARE
    balance_record user_paid_analyses_balance;
BEGIN
    -- Get current balance
    SELECT * INTO balance_record
    FROM user_paid_analyses_balance
    WHERE user_id = p_user_id;
    
    -- If no balance or no remaining analyses, return false
    IF NOT FOUND OR balance_record.remaining_analyses <= 0 THEN
        RETURN FALSE;
    END IF;
    
    -- Consume one analysis
    UPDATE user_paid_analyses_balance
    SET 
        remaining_analyses = remaining_analyses - 1,
        total_used = total_used + 1,
        updated_at = NOW()
    WHERE user_id = p_user_id;
    
    RETURN TRUE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to get user's paid analyses balance
CREATE OR REPLACE FUNCTION get_paid_analyses_balance(p_user_id UUID)
RETURNS TABLE (
    remaining_analyses INTEGER,
    total_purchased INTEGER,
    total_used INTEGER,
    package_type VARCHAR(50),
    purchase_history JSONB
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        COALESCE(upab.remaining_analyses, 0) as remaining_analyses,
        COALESCE(upab.total_purchased, 0) as total_purchased,
        COALESCE(upab.total_used, 0) as total_used,
        COALESCE(upab.package_type, 'individual') as package_type,
        COALESCE(upab.purchase_history, '[]'::jsonb) as purchase_history
    FROM user_paid_analyses_balance upab
    WHERE upab.user_id = p_user_id
    
    UNION ALL
    
    SELECT 0, 0, 0, 'individual', '[]'::jsonb
    WHERE NOT EXISTS (
        SELECT 1 FROM user_paid_analyses_balance WHERE user_id = p_user_id
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create trigger to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_paid_analyses_balance_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_paid_analyses_balance_updated_at
    BEFORE UPDATE ON user_paid_analyses_balance
    FOR EACH ROW
    EXECUTE FUNCTION update_paid_analyses_balance_updated_at();

-- Grant necessary permissions
GRANT SELECT, INSERT, UPDATE ON user_paid_analyses_balance TO authenticated;
GRANT EXECUTE ON FUNCTION get_or_create_paid_analyses_balance(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION add_paid_analyses(UUID, INTEGER, VARCHAR, TEXT, DECIMAL) TO authenticated;
GRANT EXECUTE ON FUNCTION consume_paid_analysis(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION get_paid_analyses_balance(UUID) TO authenticated;

-- Source: 20250122_update_monthly_usage_with_paid_balance.sql
-- Update get_current_monthly_usage to include paid analyses balance
CREATE OR REPLACE FUNCTION get_current_monthly_usage()
RETURNS JSONB AS $$
DECLARE
  current_year INTEGER := EXTRACT(YEAR FROM NOW());
  current_month INTEGER := EXTRACT(MONTH FROM NOW());
  usage_record user_monthly_usage;
  paid_balance_record RECORD;
  free_limit INTEGER;
  actual_total_analyses INTEGER := 0;
  actual_free_analyses INTEGER := 0;
  actual_paid_analyses INTEGER := 0;
  user_workshop_id UUID;
  remaining_paid_analyses INTEGER := 0;
BEGIN
  -- Obtener configuraciones del sistema
  SELECT (get_system_setting('monthly_free_analyses_limit')->>'value')::INTEGER INTO free_limit;
  
  -- Obtener el workshop_id del usuario actual
  SELECT workshop_id INTO user_workshop_id 
  FROM profiles 
  WHERE id = auth.uid();
  
  -- Contar análisis reales del mes actual desde la tabla analysis
  SELECT COUNT(*) INTO actual_total_analyses
  FROM analysis 
  WHERE workshop_id = user_workshop_id
    AND EXTRACT(YEAR FROM created_at) = current_year
    AND EXTRACT(MONTH FROM created_at) = current_month;
  
  -- Calcular análisis gratuitos y de pago basado en el límite
  actual_free_analyses := LEAST(actual_total_analyses, free_limit);
  actual_paid_analyses := GREATEST(0, actual_total_analyses - free_limit);
  
  -- Obtener balance de análisis pagados
  SELECT * INTO paid_balance_record 
  FROM get_paid_analyses_balance(auth.uid()) 
  LIMIT 1;
  
  IF paid_balance_record IS NOT NULL THEN
    remaining_paid_analyses := paid_balance_record.remaining_analyses;
  ELSE
    remaining_paid_analyses := 0;
  END IF;
  
  -- Obtener registro de uso mensual (crear si no existe) para obtener payment_status y total_amount_due
  SELECT * INTO usage_record FROM get_or_create_monthly_usage(current_year, current_month);
  
  RETURN jsonb_build_object(
    'total_analyses', actual_total_analyses,
    'free_analyses_used', actual_free_analyses,
    'paid_analyses_count', actual_paid_analyses,
    'free_analyses_limit', free_limit,
    'remaining_free_analyses', GREATEST(0, free_limit - actual_free_analyses),
    'remaining_paid_analyses', remaining_paid_analyses,
    'total_amount_due', usage_record.total_amount_due,
    'payment_status', usage_record.payment_status,
    'year', current_year,
    'month', current_month
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Update increment_analysis_count to consume paid analyses when free analyses are exhausted
CREATE OR REPLACE FUNCTION increment_analysis_count()
RETURNS JSONB AS $$
DECLARE
  current_year INTEGER := EXTRACT(YEAR FROM NOW());
  current_month INTEGER := EXTRACT(MONTH FROM NOW());
  usage_record user_monthly_usage;
  free_limit INTEGER;
  additional_price DECIMAL;
  billing_enabled BOOLEAN;
  current_total_analyses INTEGER := 0;
  user_workshop_id UUID;
  is_free_analysis BOOLEAN := FALSE;
  amount_to_charge DECIMAL := 0;
  paid_analysis_consumed BOOLEAN := FALSE;
  remaining_paid_analyses INTEGER := 0;
BEGIN
  -- Obtener configuraciones del sistema
  SELECT (get_system_setting('monthly_free_analyses_limit')->>'value')::INTEGER INTO free_limit;
  SELECT (get_system_setting('additional_analysis_price')->>'value')::DECIMAL INTO additional_price;
  SELECT (get_system_setting('billing_enabled')->>'value')::BOOLEAN INTO billing_enabled;
  
  -- Obtener el workshop_id del usuario actual
  SELECT workshop_id INTO user_workshop_id 
  FROM profiles 
  WHERE id = auth.uid();
  
  -- Contar análisis reales del mes actual
  SELECT COUNT(*) INTO current_total_analyses
  FROM analysis 
  WHERE workshop_id = user_workshop_id
    AND EXTRACT(YEAR FROM created_at) = current_year
    AND EXTRACT(MONTH FROM created_at) = current_month;
  
  -- Determinar si este análisis es gratuito, de pago con balance, o requiere pago
  IF current_total_analyses < free_limit THEN
    -- Análisis gratuito
    is_free_analysis := TRUE;
  ELSE
    -- Análisis de pago - intentar consumir del balance primero
    SELECT consume_paid_analysis(auth.uid()) INTO paid_analysis_consumed;
    
    IF paid_analysis_consumed THEN
      -- Se consumió un análisis del balance pagado
      is_free_analysis := FALSE;
      amount_to_charge := 0;
    ELSE
      -- No hay balance pagado, cobrar si la facturación está habilitada
      IF billing_enabled THEN
        amount_to_charge := additional_price;
      END IF;
    END IF;
  END IF;
  
  -- Obtener o crear registro de uso mensual
  SELECT * INTO usage_record FROM get_or_create_monthly_usage(current_year, current_month);
  
  -- Solo actualizar el total_amount_due si hay cargo
  IF amount_to_charge > 0 THEN
    UPDATE user_monthly_usage 
    SET 
      total_amount_due = total_amount_due + amount_to_charge,
      updated_at = NOW()
    WHERE user_id = auth.uid() 
      AND year = current_year 
      AND month = current_month;
  END IF;
  
  -- Obtener análisis pagados restantes después de la operación
  SELECT remaining_analyses INTO remaining_paid_analyses
  FROM get_paid_analyses_balance(auth.uid())
  LIMIT 1;
  
  IF remaining_paid_analyses IS NULL THEN
    remaining_paid_analyses := 0;
  END IF;
  
  -- Retornar información sobre el análisis
  RETURN jsonb_build_object(
    'is_free', is_free_analysis,
    'paid_analysis_consumed', paid_analysis_consumed,
    'amount_charged', amount_to_charge,
    'total_analyses', current_total_analyses + 1,
    'free_analyses_used', LEAST(current_total_analyses + 1, free_limit),
    'free_analyses_limit', free_limit,
    'remaining_paid_analyses', remaining_paid_analyses
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to check if user can create analysis (considering both free and paid analyses)
CREATE OR REPLACE FUNCTION can_user_create_analysis()
RETURNS JSONB AS $$
DECLARE
  current_year INTEGER := EXTRACT(YEAR FROM NOW());
  current_month INTEGER := EXTRACT(MONTH FROM NOW());
  free_limit INTEGER;
  billing_enabled BOOLEAN;
  current_total_analyses INTEGER := 0;
  user_workshop_id UUID;
  remaining_paid_analyses INTEGER := 0;
  can_create BOOLEAN := FALSE;
  reason TEXT := '';
BEGIN
  -- Obtener configuraciones del sistema
  SELECT (get_system_setting('monthly_free_analyses_limit')->>'value')::INTEGER INTO free_limit;
  SELECT (get_system_setting('billing_enabled')->>'value')::BOOLEAN INTO billing_enabled;
  
  -- Obtener el workshop_id del usuario actual
  SELECT workshop_id INTO user_workshop_id 
  FROM profiles 
  WHERE id = auth.uid();
  
  -- Contar análisis reales del mes actual
  SELECT COUNT(*) INTO current_total_analyses
  FROM analysis 
  WHERE workshop_id = user_workshop_id
    AND EXTRACT(YEAR FROM created_at) = current_year
    AND EXTRACT(MONTH FROM created_at) = current_month;
  
  -- Obtener análisis pagados restantes
  SELECT remaining_analyses INTO remaining_paid_analyses
  FROM get_paid_analyses_balance(auth.uid())
  LIMIT 1;
  
  IF remaining_paid_analyses IS NULL THEN
    remaining_paid_analyses := 0;
  END IF;
  
  -- Determinar si puede crear análisis
  IF current_total_analyses < free_limit THEN
    -- Tiene análisis gratuitos disponibles
    can_create := TRUE;
    reason := 'free_analysis_available';
  ELSIF remaining_paid_analyses > 0 THEN
    -- Tiene análisis pagados disponibles
    can_create := TRUE;
    reason := 'paid_analysis_available';
  ELSIF billing_enabled THEN
    -- Puede pagar por análisis adicional
    can_create := TRUE;
    reason := 'payment_required';
  ELSE
    -- No puede crear más análisis
    can_create := FALSE;
    reason := 'limit_reached_billing_disabled';
  END IF;
  
  RETURN jsonb_build_object(
    'can_create', can_create,
    'reason', reason,
    'free_analyses_used', LEAST(current_total_analyses, free_limit),
    'free_analyses_limit', free_limit,
    'remaining_free_analyses', GREATEST(0, free_limit - current_total_analyses),
    'remaining_paid_analyses', remaining_paid_analyses,
    'billing_enabled', billing_enabled
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Grant permissions for the new function
GRANT EXECUTE ON FUNCTION can_user_create_analysis() TO authenticated;

-- Source: 20250123_create_analysis_packages.sql
-- Crear tabla de paquetes de análisis
CREATE TABLE IF NOT EXISTS analysis_packages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    analyses_count INTEGER NOT NULL CHECK (analyses_count > 0),
    price_per_analysis DECIMAL(10,2) NOT NULL CHECK (price_per_analysis > 0),
    total_price DECIMAL(10,2) NOT NULL CHECK (total_price > 0),
    discount_percentage DECIMAL(5,2) DEFAULT 0 CHECK (discount_percentage >= 0 AND discount_percentage <= 100),
    is_active BOOLEAN DEFAULT true,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crear índices
CREATE INDEX idx_analysis_packages_active ON analysis_packages(is_active);
CREATE INDEX idx_analysis_packages_sort_order ON analysis_packages(sort_order);

-- Trigger para updated_at
CREATE OR REPLACE FUNCTION update_analysis_packages_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_analysis_packages_updated_at
    BEFORE UPDATE ON analysis_packages
    FOR EACH ROW
    EXECUTE FUNCTION update_analysis_packages_updated_at();

-- Insertar paquetes predefinidos
INSERT INTO analysis_packages (name, description, analyses_count, price_per_analysis, total_price, discount_percentage, sort_order) VALUES
('Análisis Individual', 'Compra un análisis individual', 1, 15.00, 15.00, 0, 1),
('Paquete Básico', 'Paquete de 10 análisis con 5% de descuento', 10, 14.25, 142.50, 5, 2),
('Paquete Estándar', 'Paquete de 50 análisis con 10% de descuento', 50, 13.50, 675.00, 10, 3),
('Paquete Premium', 'Paquete de 100 análisis con 15% de descuento', 100, 12.75, 1275.00, 15, 4),
('Paquete Empresarial', 'Paquete de 500 análisis con 20% de descuento', 500, 12.00, 6000.00, 20, 5);

-- Función para obtener paquetes activos
CREATE OR REPLACE FUNCTION get_active_analysis_packages()
RETURNS TABLE (
    id UUID,
    name VARCHAR(100),
    description TEXT,
    analyses_count INTEGER,
    price_per_analysis DECIMAL(10,2),
    total_price DECIMAL(10,2),
    discount_percentage DECIMAL(5,2),
    sort_order INTEGER
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id,
        p.name,
        p.description,
        p.analyses_count,
        p.price_per_analysis,
        p.total_price,
        p.discount_percentage,
        p.sort_order
    FROM analysis_packages p
    WHERE p.is_active = true
    ORDER BY p.sort_order ASC;
END;
$$ LANGUAGE plpgsql;

-- Función para obtener un paquete por ID
CREATE OR REPLACE FUNCTION get_analysis_package_by_id(package_id UUID)
RETURNS TABLE (
    id UUID,
    name VARCHAR(100),
    description TEXT,
    analyses_count INTEGER,
    price_per_analysis DECIMAL(10,2),
    total_price DECIMAL(10,2),
    discount_percentage DECIMAL(5,2)
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id,
        p.name,
        p.description,
        p.analyses_count,
        p.price_per_analysis,
        p.total_price,
        p.discount_percentage
    FROM analysis_packages p
    WHERE p.id = package_id AND p.is_active = true;
END;
$$ LANGUAGE plpgsql;

-- Políticas RLS
ALTER TABLE analysis_packages ENABLE ROW LEVEL SECURITY;

-- Política para lectura (todos pueden ver paquetes activos)
CREATE POLICY "Anyone can view active analysis packages" ON analysis_packages
    FOR SELECT USING (is_active = true);

-- Política para administradores (pueden hacer todo)
CREATE POLICY "Admins can manage analysis packages" ON analysis_packages
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM auth.users 
            WHERE auth.users.id = auth.uid() 
            AND auth.users.raw_user_meta_data->>'role' = 'admin'
        )
    );

-- Comentarios
COMMENT ON TABLE analysis_packages IS 'Tabla que almacena los diferentes paquetes de análisis disponibles para compra';
COMMENT ON COLUMN analysis_packages.analyses_count IS 'Número de análisis incluidos en el paquete';
COMMENT ON COLUMN analysis_packages.price_per_analysis IS 'Precio por análisis individual en este paquete';
COMMENT ON COLUMN analysis_packages.total_price IS 'Precio total del paquete';
COMMENT ON COLUMN analysis_packages.discount_percentage IS 'Porcentaje de descuento aplicado respecto al precio individual';

-- Source: 20250124_add_missing_package_functions.sql
-- Crear función get_active_packages (alias para get_active_analysis_packages)
CREATE OR REPLACE FUNCTION get_active_packages()
RETURNS TABLE (
    id UUID,
    name VARCHAR(100),
    description TEXT,
    analyses_count INTEGER,
    price_per_analysis DECIMAL(10,2),
    total_price DECIMAL(10,2),
    discount_percentage DECIMAL(5,2),
    sort_order INTEGER
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id,
        p.name,
        p.description,
        p.analyses_count,
        p.price_per_analysis,
        p.total_price,
        p.discount_percentage,
        p.sort_order
    FROM analysis_packages p
    WHERE p.is_active = true
    ORDER BY p.sort_order ASC;
END;
$$ LANGUAGE plpgsql;

-- Crear función get_package_by_id (alias para get_analysis_package_by_id)
CREATE OR REPLACE FUNCTION get_package_by_id(package_id UUID)
RETURNS TABLE (
    id UUID,
    name VARCHAR(100),
    description TEXT,
    analyses_count INTEGER,
    price_per_analysis DECIMAL(10,2),
    total_price DECIMAL(10,2),
    discount_percentage DECIMAL(5,2)
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id,
        p.name,
        p.description,
        p.analyses_count,
        p.price_per_analysis,
        p.total_price,
        p.discount_percentage
    FROM analysis_packages p
    WHERE p.id = package_id AND p.is_active = true;
END;
$$ LANGUAGE plpgsql;

-- Source: 20250124_fix_package_type_constraint.sql
-- Fix package_type constraint to match actual packages
ALTER TABLE user_paid_analyses_balance 
DROP CONSTRAINT IF EXISTS user_paid_analyses_balance_package_type_check;

ALTER TABLE user_paid_analyses_balance 
ADD CONSTRAINT user_paid_analyses_balance_package_type_check 
CHECK (package_type IN ('individual', 'basic', 'professional', 'enterprise'));

-- Source: 20250125_add_analysis_trigger.sql
-- Add trigger to automatically call increment_analysis_count when an analysis is created
-- This ensures that paid analyses are properly decremented from user balance

CREATE OR REPLACE FUNCTION trigger_increment_analysis_count()
RETURNS TRIGGER AS $$
DECLARE
  analysis_result JSONB;
BEGIN
  -- Call increment_analysis_count to handle the analysis counting logic
  -- This will consume paid analyses if available, or handle billing
  SELECT increment_analysis_count() INTO analysis_result;
  
  -- Log the result for debugging (optional)
  RAISE LOG 'Analysis count incremented for user %: %', auth.uid(), analysis_result;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create trigger that fires AFTER INSERT on analysis table
CREATE TRIGGER trigger_analysis_count_increment
  AFTER INSERT ON analysis
  FOR EACH ROW
  EXECUTE FUNCTION trigger_increment_analysis_count();

-- Grant necessary permissions
GRANT EXECUTE ON FUNCTION trigger_increment_analysis_count() TO authenticated;

-- Source: 20250125_cleanup_create_payment_record_overloads.sql
-- Cleanup create_payment_record function overloads
-- Remove all existing versions and keep only the most recent one

-- Drop all existing versions of create_payment_record
DROP FUNCTION IF EXISTS create_payment_record(
  workshop_id_param UUID,
  user_id_param UUID,
  stripe_payment_intent_id_param TEXT,
  stripe_session_id_param TEXT,
  amount_cents_param INTEGER,
  currency_param TEXT,
  analysis_month_param TEXT,
  description_param TEXT
);

DROP FUNCTION IF EXISTS create_payment_record(
  user_id_param UUID,
  workshop_id_param UUID,
  stripe_payment_intent_id_param TEXT,
  stripe_session_id_param TEXT,
  amount_cents_param INTEGER,
  currency_param TEXT,
  analysis_month_param TEXT,
  analyses_purchased_param INTEGER,
  unit_price_cents_param INTEGER,
  description_param TEXT,
  stripe_customer_id_param TEXT
);

DROP FUNCTION IF EXISTS create_payment_record(
  workshop_id_param UUID,
  user_id_param UUID,
  stripe_payment_intent_id_param TEXT,
  stripe_session_id_param TEXT,
  stripe_customer_id_param TEXT,
  amount_cents_param INTEGER,
  currency_param TEXT,
  analysis_month_param TEXT,
  description_param TEXT
);

-- Create the final version of create_payment_record
CREATE OR REPLACE FUNCTION create_payment_record(
  workshop_id_param UUID,
  user_id_param UUID,
  stripe_payment_intent_id_param TEXT,
  stripe_session_id_param TEXT,
  amount_cents_param INTEGER,
  stripe_customer_id_param TEXT DEFAULT NULL,
  currency_param TEXT DEFAULT 'EUR',
  analysis_month_param TEXT DEFAULT NULL,
  description_param TEXT DEFAULT NULL
)
RETURNS UUID AS $$
DECLARE
  payment_id UUID;
  current_month TEXT;
BEGIN
  -- Usar el mes actual si no se proporciona
  current_month := COALESCE(analysis_month_param, TO_CHAR(NOW(), 'YYYY-MM'));
  
  -- Insertar registro de pago
  INSERT INTO payments (
    workshop_id,
    user_id,
    stripe_payment_intent_id,
    stripe_session_id,
    stripe_customer_id,
    amount_cents,
    currency,
    status,
    analysis_month,
    analyses_purchased,
    unit_price_cents,
    description
  ) VALUES (
    workshop_id_param,
    user_id_param,
    stripe_payment_intent_id_param,
    stripe_session_id_param,
    stripe_customer_id_param,
    amount_cents_param,
    currency_param,
    'pending',
    current_month,
    1, -- Por defecto 1 análisis
    amount_cents_param, -- Por ahora el precio unitario es igual al total
    description_param
  ) RETURNING id INTO payment_id;

  RETURN payment_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Source: 20250125_create_payment_balance_trigger.sql
-- Trigger automático para registrar balance cuando un payment se completa
-- Este trigger se ejecuta cuando el status de un payment cambia a 'completed'

CREATE OR REPLACE FUNCTION trigger_add_paid_analyses_on_payment_completion()
RETURNS TRIGGER AS $$
DECLARE
  package_data RECORD;
  analyses_to_add INTEGER := 0;
  package_type_value VARCHAR(50) := 'individual';
  amount_paid_euros DECIMAL;
  analysis_price DECIMAL;
BEGIN
  -- Solo procesar si el status cambió a 'completed' y antes no era 'completed'
  IF NEW.status = 'completed' AND (OLD.status IS NULL OR OLD.status != 'completed') THEN
    
    RAISE LOG 'Payment completion trigger fired for payment_id: %, user_id: %', NEW.id, NEW.user_id;
    
    -- Convertir amount_cents a euros
    amount_paid_euros := NEW.amount_cents / 100.0;
    
    -- Intentar obtener datos del paquete desde los metadatos de Stripe
    -- Primero buscar por package_id si existe en description o metadata
    IF NEW.description IS NOT NULL AND NEW.description LIKE '%package_id:%' THEN
      -- Extraer package_id de la descripción (formato: "package_id:uuid")
      DECLARE
        package_id_text TEXT;
        package_uuid UUID;
      BEGIN
        package_id_text := substring(NEW.description from 'package_id:([a-f0-9-]+)');
        package_uuid := package_id_text::UUID;
        
        SELECT * INTO package_data
        FROM analysis_packages
        WHERE id = package_uuid AND is_active = true;
        
        IF FOUND THEN
          analyses_to_add := package_data.analyses_count;
          package_type_value := CASE 
            WHEN package_data.analyses_count = 1 THEN 'individual'
            WHEN package_data.analyses_count <= 10 THEN 'basic'
            WHEN package_data.analyses_count <= 50 THEN 'professional'
            ELSE 'enterprise'
          END;
          RAISE LOG 'Found package data: % analyses, type: %', analyses_to_add, package_type_value;
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE LOG 'Error parsing package_id from description: %', SQLERRM;
      END;
    END IF;
    
    -- Si no encontramos paquete, usar fallback basado en analyses_purchased
    IF analyses_to_add = 0 AND NEW.analyses_purchased IS NOT NULL AND NEW.analyses_purchased > 0 THEN
      analyses_to_add := NEW.analyses_purchased;
      package_type_value := CASE 
        WHEN analyses_to_add = 1 THEN 'individual'
        WHEN analyses_to_add <= 10 THEN 'basic'
        WHEN analyses_to_add <= 50 THEN 'professional'
        ELSE 'enterprise'
      END;
      RAISE LOG 'Using analyses_purchased fallback: % analyses, type: %', analyses_to_add, package_type_value;
    END IF;
    
    -- Si aún no tenemos análisis, calcular basado en precio del sistema
    IF analyses_to_add = 0 THEN
      SELECT (setting_value->>'value')::DECIMAL INTO analysis_price
      FROM system_settings
      WHERE setting_key = 'additional_analysis_price';
      
      IF analysis_price IS NOT NULL AND analysis_price > 0 THEN
        analyses_to_add := GREATEST(1, FLOOR(amount_paid_euros / analysis_price));
        package_type_value := 'individual';
        RAISE LOG 'Using price-based fallback: % analyses (%.2f / %.2f)', analyses_to_add, amount_paid_euros, analysis_price;
      ELSE
        -- Último fallback: 1 análisis por cada 15 euros
        analyses_to_add := GREATEST(1, FLOOR(amount_paid_euros / 15.0));
        package_type_value := 'individual';
        RAISE LOG 'Using final fallback: % analyses (%.2f / 15.0)', analyses_to_add, amount_paid_euros;
      END IF;
    END IF;
    
    -- Llamar a add_paid_analyses si tenemos análisis que añadir
    IF analyses_to_add > 0 THEN
      RAISE LOG 'Calling add_paid_analyses with: user_id=%, analyses_count=%, package_type=%, payment_intent_id=%, amount_paid=%.2f', 
        NEW.user_id, analyses_to_add, package_type_value, NEW.stripe_payment_intent_id, amount_paid_euros;
      
      PERFORM add_paid_analyses(
        p_user_id := NEW.user_id,
        p_analyses_count := analyses_to_add,
        p_package_type := package_type_value,
        p_stripe_payment_intent_id := NEW.stripe_payment_intent_id,
        p_amount_paid := amount_paid_euros
      );
      
      RAISE LOG 'Successfully added % paid analyses for user %', analyses_to_add, NEW.user_id;
    ELSE
      RAISE LOG 'No analyses to add for payment %', NEW.id;
    END IF;
    
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Crear el trigger que se ejecuta AFTER UPDATE en la tabla payments
CREATE TRIGGER trigger_payment_completion_add_balance
  AFTER UPDATE ON payments
  FOR EACH ROW
  EXECUTE FUNCTION trigger_add_paid_analyses_on_payment_completion();

-- Grant permissions
GRANT EXECUTE ON FUNCTION trigger_add_paid_analyses_on_payment_completion() TO authenticated;

-- Comentarios
COMMENT ON FUNCTION trigger_add_paid_analyses_on_payment_completion() IS 'Trigger function que automáticamente añade análisis pagados al balance del usuario cuando un payment se completa';
COMMENT ON TRIGGER trigger_payment_completion_add_balance ON payments IS 'Trigger que ejecuta add_paid_analyses automáticamente cuando un payment cambia a status completed';

-- Source: 20250125_fix_update_payment_status_session_id.sql
-- Corregir la función update_payment_status para que funcione con session_id y devuelva user_id
-- Esta función es necesaria para que el webhook de Stripe pueda continuar con add_paid_analyses

CREATE OR REPLACE FUNCTION update_payment_status(
  session_id_param TEXT,
  new_status TEXT,
  payment_method_param TEXT DEFAULT NULL,
  stripe_fee_cents_param INTEGER DEFAULT NULL,
  net_amount_cents_param INTEGER DEFAULT NULL,
  stripe_customer_id_param TEXT DEFAULT NULL
)
RETURNS TABLE(user_id UUID, payment_id UUID) AS $$
DECLARE
  payment_record payments;
BEGIN
  -- Actualizar el estado del pago usando session_id
  UPDATE payments 
  SET 
    status = new_status,
    payment_method = COALESCE(payment_method_param, payment_method),
    stripe_fee_cents = COALESCE(stripe_fee_cents_param, stripe_fee_cents),
    stripe_customer_id = COALESCE(stripe_customer_id_param, stripe_customer_id),
    net_amount_cents = COALESCE(net_amount_cents_param, net_amount_cents),
    paid_at = CASE WHEN new_status = 'completed' THEN NOW() ELSE paid_at END,
    updated_at = NOW()
  WHERE stripe_session_id = session_id_param
  RETURNING * INTO payment_record;
  
  -- Si encontramos el pago, devolver user_id y payment_id
  IF payment_record.id IS NOT NULL THEN
    -- Si el pago fue exitoso, actualizar el estado en user_monthly_usage
    IF new_status = 'completed' THEN
      PERFORM mark_payment_completed(payment_record.stripe_payment_intent_id);
    END IF;
    
    -- Devolver los datos necesarios para el webhook
    RETURN QUERY SELECT payment_record.user_id, payment_record.id;
  ELSE
    -- Si no se encontró el pago, devolver NULL
    RETURN QUERY SELECT NULL::UUID, NULL::UUID;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Source: 20250125_fix_user_paid_analyses_balance_fkey.sql
-- Fix foreign key constraint in user_paid_analyses_balance to point to auth.users instead of public.users

-- Drop the incorrect foreign key constraint
ALTER TABLE user_paid_analyses_balance 
DROP CONSTRAINT user_paid_analyses_balance_user_id_fkey;

-- Add the correct foreign key constraint pointing to auth.users
ALTER TABLE user_paid_analyses_balance 
ADD CONSTRAINT user_paid_analyses_balance_user_id_fkey 
FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;

-- Source: 20250125_update_trigger_with_package_id.sql
-- Actualizar el trigger para usar correctamente el campo package_id
-- Esta migración reemplaza la lógica anterior que parseaba la descripción

CREATE OR REPLACE FUNCTION trigger_add_paid_analyses_on_payment_completion()
RETURNS TRIGGER AS $$
DECLARE
    package_data RECORD;
    analyses_to_add INTEGER;
    package_type VARCHAR(50);
    amount_paid DECIMAL(10,2);
BEGIN
    -- Solo procesar si el estado cambió a 'completed'
    IF NEW.status = 'completed' AND OLD.status != 'completed' THEN
        
        -- Calcular el monto pagado en euros (convertir de centavos)
        amount_paid := NEW.amount_cents / 100.0;
        
        -- Si tenemos package_id, obtener datos del paquete directamente
        IF NEW.package_id IS NOT NULL THEN
            SELECT 
                name,
                analyses_count
            INTO package_data
            FROM analysis_packages 
            WHERE id = NEW.package_id AND is_active = true;
            
            IF FOUND THEN
                analyses_to_add := package_data.analyses_count;
                package_type := package_data.name;
                
                RAISE LOG 'Trigger: Usando package_id %, paquete: %, análisis: %', 
                    NEW.package_id, package_type, analyses_to_add;
            ELSE
                RAISE LOG 'Trigger: Package_id % no encontrado o inactivo', NEW.package_id;
                -- Fallback: usar analyses_purchased del payment
                analyses_to_add := COALESCE(NEW.analyses_purchased, 1);
                package_type := 'Paquete no encontrado';
            END IF;
        ELSE
            -- Fallback: usar analyses_purchased del payment
            analyses_to_add := COALESCE(NEW.analyses_purchased, 1);
            package_type := 'Sin package_id';
            
            RAISE LOG 'Trigger: Sin package_id, usando analyses_purchased: %', analyses_to_add;
        END IF;
        
        -- Llamar a la función add_paid_analyses
        BEGIN
            PERFORM add_paid_analyses(
                p_user_id := NEW.user_id,
                p_analyses_count := analyses_to_add,
                p_package_type := package_type,
                p_stripe_payment_intent_id := NEW.stripe_payment_intent_id,
                p_amount_paid := amount_paid
            );
            
            RAISE LOG 'Trigger: add_paid_analyses ejecutado exitosamente para user_id: %, análisis: %, tipo: %', 
                NEW.user_id, analyses_to_add, package_type;
                
        EXCEPTION WHEN OTHERS THEN
            RAISE LOG 'Trigger: Error al ejecutar add_paid_analyses: %', SQLERRM;
            -- No re-lanzar el error para evitar que falle la transacción del payment
        END;
        
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Comentario actualizado
COMMENT ON FUNCTION trigger_add_paid_analyses_on_payment_completion() IS 'Trigger function que automáticamente añade análisis pagados al balance del usuario cuando un payment se completa. Utiliza el campo package_id para obtener datos exactos del paquete.';

-- Source: 20250127_add_valuation_date_to_analysis.sql
-- Add valuation_date and analysis_date fields to analysis table
ALTER TABLE analysis 
ADD COLUMN IF NOT EXISTS valuation_date DATE,
ADD COLUMN IF NOT EXISTS analysis_date DATE;

-- Add index for efficient queries on valuation_date
CREATE INDEX IF NOT EXISTS idx_analysis_valuation_date ON analysis(valuation_date);
CREATE INDEX IF NOT EXISTS idx_analysis_analysis_date ON analysis(analysis_date);

-- Source: 20250128_add_spare_parts_quantity.sql
-- Agregar campo de cantidad de repuestos a la tabla insurance_amounts
ALTER TABLE insurance_amounts
ADD COLUMN IF NOT EXISTS spare_parts_quantity INTEGER;

COMMENT ON COLUMN insurance_amounts.spare_parts_quantity IS 'Cantidad total de ítems/elementos de repuestos extraídos del PDF';



-- ===========================
-- DATA EXPORT
-- ===========================

-- Orden de carga: workshops -> profiles -> resto
-- (auth.users se carga al principio del archivo, ver cabecera)

-- ---------------------------------------------------------------------------
-- Reconciliar el esquema con la BD de produccion de la que salio el export.
-- Ninguna migracion de este archivo recoge estos cambios: se hicieron
-- directamente sobre produccion, asi que hay que replicarlos aqui.
-- ---------------------------------------------------------------------------

-- 45 de las 76 filas de analysis tienen workshop_id NULL
ALTER TABLE analysis ALTER COLUMN workshop_id DROP NOT NULL;

-- package_type guarda nombres comerciales ('Pack Basico', 'Pack Individual'),
-- no los identificadores del CHECK original ('individual', 'package_5', ...)
ALTER TABLE user_paid_analyses_balance
DROP CONSTRAINT IF EXISTS user_paid_analyses_balance_package_type_check;

-- Columnas presentes en produccion que ninguna migracion crea.
-- Definiciones tomadas de src/integrations/supabase/types.ts:
-- analysis.user_id es NOT NULL y su FK (analysis_user_id_fkey) apunta a profiles(id).
ALTER TABLE analysis
ADD COLUMN IF NOT EXISTS user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE;

-- payments.package_id lo usa el trigger de 20250125_update_trigger_with_package_id,
-- que tolera ids ausentes ('Package_id % no encontrado'), asi que va sin FK.
ALTER TABLE payments
ADD COLUMN IF NOT EXISTS package_id UUID;

-- El trigger AFTER INSERT sobre analysis llama a increment_analysis_count(), que
-- usa auth.uid(). En el SQL Editor auth.uid() es NULL y get_or_create_monthly_usage()
-- intentaria insertar user_monthly_usage.user_id = NULL (columna NOT NULL).
-- Ademas consumiria saldo de los usuarios al recargar sus analisis historicos.
ALTER TABLE analysis DISABLE TRIGGER trigger_analysis_count_increment;

-- Source: 20260806_fix_analysis_and_packages_rls.sql
-- (va aqui y no en su orden cronologico porque depende de analysis.user_id, que
--  solo existe a partir del ALTER TABLE de reconciliacion de mas arriba)
-- Arreglar los dos 42501 de la seccion de analisis.
--
-- 1) get_active_packages() devolvia 403 "permission denied for table users".
--    La politica de admin de analysis_packages consulta auth.users, tabla sobre la
--    que anon/authenticated no tienen SELECT. Al ser FOR ALL tambien se evalua en
--    los SELECT que hace la funcion (que no es SECURITY DEFINER), asi que la
--    lectura entera abortaba. Mismo bug que ya se corrigio para workshops en
--    20241016_fix_all_rls_policies.sql: comprobar el rol via auth.jwt().
--
-- 2) El INSERT en analysis devolvia 403 "new row violates row-level security
--    policy". Las politicas de 20241019_create_analysis_table.sql solo aceptan
--    filas cuyo workshop_id pertenezca al taller del perfil, pero el esquema
--    cambio despues: workshop_id es NULLABLE y se anadio analysis.user_id NOT NULL.
--    Para un usuario sin taller el WITH CHECK evalua NULL IN (...) -> NULL, y RLS
--    rechaza. Se anaden politicas por user_id que se suman (OR) a las existentes
--    por taller.

DROP POLICY IF EXISTS "Admins can manage analysis packages" ON analysis_packages;
DROP POLICY IF EXISTS "Admins can manage analysis packages v2" ON analysis_packages;

CREATE POLICY "Admins can manage analysis packages v2" ON analysis_packages
    FOR ALL USING (
        (auth.jwt() ->> 'user_metadata')::jsonb ->> 'role' = 'admin'
        OR
        (auth.jwt() ->> 'raw_user_meta_data')::jsonb ->> 'role' = 'admin'
    );

DROP POLICY IF EXISTS "Users can view their own analysis" ON analysis;
CREATE POLICY "Users can view their own analysis" ON analysis
    FOR SELECT USING (user_id = auth.uid());

DROP POLICY IF EXISTS "Users can insert their own analysis" ON analysis;
CREATE POLICY "Users can insert their own analysis" ON analysis
    FOR INSERT WITH CHECK (
        user_id = auth.uid()
        AND (
            workshop_id IS NULL
            OR workshop_id IN (SELECT workshop_id FROM profiles WHERE id = auth.uid())
        )
    );

DROP POLICY IF EXISTS "Users can update their own analysis" ON analysis;
CREATE POLICY "Users can update their own analysis" ON analysis
    FOR UPDATE USING (user_id = auth.uid())
    WITH CHECK (
        user_id = auth.uid()
        AND (
            workshop_id IS NULL
            OR workshop_id IN (SELECT workshop_id FROM profiles WHERE id = auth.uid())
        )
    );

-- Source: 20260806_fix_extracted_data_rls.sql
-- (va aqui por la misma razon: depende de analysis.user_id)
--
-- Las politicas de vehicle_data e insurance_amounts (20241020_create_extracted_data_tables.sql)
-- filtran por analysis_id IN (SELECT id FROM analysis WHERE workshop_id = auth.uid()),
-- es decir, comparan un uuid de taller con un uuid de usuario: nunca es cierto.
-- El cliente escribe en las dos tablas con la sesion del usuario en ambas rutas del
-- flujo (NewAnalysis.tsx:232/:270 y el fallback de IA en :670/:707) y tambien las
-- lee/actualiza en Verification.tsx y Results.tsx, asi que el guardado de los datos
-- extraidos fallaba con 42501 aunque el INSERT en analysis ya funcione.

DROP POLICY IF EXISTS "Users can view their own vehicle data v2" ON vehicle_data;
CREATE POLICY "Users can view their own vehicle data v2" ON vehicle_data
    FOR SELECT USING (
        analysis_id IN (SELECT id FROM analysis WHERE user_id = auth.uid())
    );

DROP POLICY IF EXISTS "Users can insert their own vehicle data v2" ON vehicle_data;
CREATE POLICY "Users can insert their own vehicle data v2" ON vehicle_data
    FOR INSERT WITH CHECK (
        analysis_id IN (SELECT id FROM analysis WHERE user_id = auth.uid())
    );

DROP POLICY IF EXISTS "Users can update their own vehicle data v2" ON vehicle_data;
CREATE POLICY "Users can update their own vehicle data v2" ON vehicle_data
    FOR UPDATE USING (
        analysis_id IN (SELECT id FROM analysis WHERE user_id = auth.uid())
    )
    WITH CHECK (
        analysis_id IN (SELECT id FROM analysis WHERE user_id = auth.uid())
    );

DROP POLICY IF EXISTS "Users can view their own insurance amounts v2" ON insurance_amounts;
CREATE POLICY "Users can view their own insurance amounts v2" ON insurance_amounts
    FOR SELECT USING (
        analysis_id IN (SELECT id FROM analysis WHERE user_id = auth.uid())
    );

DROP POLICY IF EXISTS "Users can insert their own insurance amounts v2" ON insurance_amounts;
CREATE POLICY "Users can insert their own insurance amounts v2" ON insurance_amounts
    FOR INSERT WITH CHECK (
        analysis_id IN (SELECT id FROM analysis WHERE user_id = auth.uid())
    );

DROP POLICY IF EXISTS "Users can update their own insurance amounts v2" ON insurance_amounts;
CREATE POLICY "Users can update their own insurance amounts v2" ON insurance_amounts
    FOR UPDATE USING (
        analysis_id IN (SELECT id FROM analysis WHERE user_id = auth.uid())
    )
    WITH CHECK (
        analysis_id IN (SELECT id FROM analysis WHERE user_id = auth.uid())
    );

-- Desactivar los paquetes de ejemplo que sembro 20250123_create_analysis_packages.sql.
-- Estan en euros (total_price 15.00, 142.50, 675.00, 1275.00, 6000.00) mientras que
-- los paquetes reales del export estan en centimos (Pack Individual = 1000 = 10 EUR), y
-- payment-session/index.ts:140 pasa total_price tal cual a Stripe como unit_amount:
-- cobrarian 0,15 EUR, 1,43 EUR, etc.
UPDATE analysis_packages
SET is_active = false
WHERE name IN (
    'Análisis Individual',
    'Paquete Básico',
    'Paquete Estándar',
    'Paquete Premium',
    'Paquete Empresarial'
);

-- Source: 20260807_add_error_message_to_analysis.sql
-- NewAnalysis.tsx:175-178 marca el analisis como 'failed' escribiendo tambien
-- error_message, columna que nunca existio (42703), asi que el PATCH entero se
-- rechazaba con 400 y los analisis fallidos se quedaban en 'processing'.
ALTER TABLE analysis
ADD COLUMN IF NOT EXISTS error_message TEXT;

COMMENT ON COLUMN analysis.error_message IS 'Mensaje del error que hizo fallar el analisis; lo rellena el manejador de errores del frontend al marcar status = failed';

-- Data for workshops
INSERT INTO public."workshops" ("id", "name", "email", "phone", "address", "created_at", "updated_at") VALUES ('c378f51e-ec17-42b6-be0d-142865116848', 'Taller Velasco', 'juanvelasco9888@gmail.com', NULL, NULL, '2025-10-22T20:07:30.48556+00:00', '2025-10-22T20:07:30.48556+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshops" ("id", "name", "email", "phone", "address", "created_at", "updated_at") VALUES ('e38941f8-5061-4114-8a2e-cb26f8e1b855', 'talle ubeda', 'info@expertpericial.com', '677161401', NULL, '2025-10-24T11:58:23.111412+00:00', '2025-10-24T11:58:23.111412+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshops" ("id", "name", "email", "phone", "address", "created_at", "updated_at") VALUES ('83899a7d-7f95-4033-aa91-71cb0b9ecdbf', 'Taller Extremadura', 'hola@expertpericial.com', '666666666', NULL, '2025-10-25T04:43:12.675261+00:00', '2025-10-25T04:43:12.675261+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshops" ("id", "name", "email", "phone", "address", "created_at", "updated_at") VALUES ('303e0a14-a30a-455d-931f-d428d859603a', 'VM Automocion ', 'vmautomocion@hotmail.es', '+34615142494', NULL, '2025-10-25T12:34:34.719074+00:00', '2025-10-25T12:34:34.719074+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshops" ("id", "name", "email", "phone", "address", "created_at", "updated_at") VALUES ('6ad0b598-a6d6-4cdd-99d6-041016b4f704', 'Chapicar', 'javaxtron@gmail.com', '662612696', NULL, '2025-10-25T12:35:52.926672+00:00', '2025-10-25T12:35:52.926672+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshops" ("id", "name", "email", "phone", "address", "created_at", "updated_at") VALUES ('32a91aea-3e16-4c27-9f13-0a48a153c40d', 'Talleres cidoncha', 'tallerescidoncha@hotmail.com', '924868601', NULL, '2025-10-25T12:36:46.94164+00:00', '2025-10-25T12:36:46.94164+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshops" ("id", "name", "email", "phone", "address", "created_at", "updated_at") VALUES ('e2241956-5cc9-4b24-80f1-7566bcd8278e', 'TALLERES RIBERA C.B. ', 'talleresribera@hotmail.es', '615128910', NULL, '2025-10-25T12:37:48.725969+00:00', '2025-10-25T12:37:48.725969+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshops" ("id", "name", "email", "phone", "address", "created_at", "updated_at") VALUES ('1681b1c1-1169-4010-883f-f0edb2f8d6e1', 'Taller Chapicar ', 'tallerchapicar@gmail.com', '635889797', NULL, '2025-10-25T12:39:20.152605+00:00', '2025-10-25T12:39:20.152605+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshops" ("id", "name", "email", "phone", "address", "created_at", "updated_at") VALUES ('0e3d6a3a-6f98-4bf4-8662-2a4e1634a2d1', 'SDS AUTOMOCION', 'sdsautomocion@gmail.com', '670278635', NULL, '2025-10-26T07:42:54.011433+00:00', '2025-10-26T07:42:54.011433+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshops" ("id", "name", "email", "phone", "address", "created_at", "updated_at") VALUES ('149109c2-d2b9-46ed-83d1-ee8a5ee57297', 'Talleres Gallardo ', 'antoniogallardos@yahoo.es', '924831618', NULL, '2025-10-26T15:36:43.874296+00:00', '2025-10-26T15:36:43.874296+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshops" ("id", "name", "email", "phone", "address", "created_at", "updated_at") VALUES ('308f1a19-94f7-48ba-93af-6f0a6967afa0', 'Taller Higini', 'higini@genaisapiens.com', '+34692213343', NULL, '2025-11-17T18:55:34.177106+00:00', '2025-11-17T18:55:34.177106+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshops" ("id", "name", "email", "phone", "address", "created_at", "updated_at") VALUES ('33d5c056-1f17-46e3-bfa8-810400083e24', 'My Mechanical Workshop', 'victorafee@gmail.com', '+34 123 456 789', NULL, '2025-12-08T22:25:42.237809+00:00', '2025-12-08T22:25:42.237809+00:00') ON CONFLICT DO NOTHING;

-- Data for profiles
INSERT INTO public."profiles" ("id", "email", "role", "full_name", "created_at", "updated_at", "workshop_id", "phone") VALUES ('90301e4a-7fde-4b77-80c0-5c2c121ccc7d', 'admin@valoraplus.com', 'admin', 'Administrador Sistema', '2025-10-13T23:17:15.225714+00:00', '2025-10-13T23:17:15.225714+00:00', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."profiles" ("id", "email", "role", "full_name", "created_at", "updated_at", "workshop_id", "phone") VALUES ('09a91c7c-419d-4f9e-b7d4-d2607559c146', 'sdsautomocion@gmail.com', 'admin_mechanic', 'Sergio Bautista Carrasco', '2025-10-26T07:42:51.778124+00:00', '2025-10-26T07:42:51.778124+00:00', '0e3d6a3a-6f98-4bf4-8662-2a4e1634a2d1', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."profiles" ("id", "email", "role", "full_name", "created_at", "updated_at", "workshop_id", "phone") VALUES ('40f338e1-54f7-4b46-9b6b-97c665d22285', 'antoniogallardos@yahoo.es', 'admin_mechanic', 'Antonio Gallardo Díaz ', '2025-10-26T15:36:41.931434+00:00', '2025-10-26T15:36:41.931434+00:00', '149109c2-d2b9-46ed-83d1-ee8a5ee57297', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."profiles" ("id", "email", "role", "full_name", "created_at", "updated_at", "workshop_id", "phone") VALUES ('30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'emilio@expertpericial.com', 'admin', 'Emilio Garcia', '2025-10-24T21:07:20.364209+00:00', '2025-10-24T21:07:20.364209+00:00', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."profiles" ("id", "email", "role", "full_name", "created_at", "updated_at", "workshop_id", "phone") VALUES ('7c97bc85-8ad5-4929-adcd-0326d183e374', 'higini@genaisapiens.com', 'admin_mechanic', 'Higini', '2025-11-17T18:55:32.01042+00:00', '2025-11-17T18:55:32.01042+00:00', '308f1a19-94f7-48ba-93af-6f0a6967afa0', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."profiles" ("id", "email", "role", "full_name", "created_at", "updated_at", "workshop_id", "phone") VALUES ('95eaba1c-5e43-4be5-8a48-e90e58b42cd0', 'hola@expertpericial.com', 'admin_mechanic', 'Juan Perez', '2025-10-25T04:43:10.64418+00:00', '2025-10-25T04:43:10.64418+00:00', '83899a7d-7f95-4033-aa91-71cb0b9ecdbf', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."profiles" ("id", "email", "role", "full_name", "created_at", "updated_at", "workshop_id", "phone") VALUES ('b0c73890-3fdf-49f2-b4af-29530c8ad59a', 'victorafee@gmail.com', 'admin_mechanic', 'Victor Afe', '2025-12-08T22:25:39.972617+00:00', '2025-12-08T22:25:39.972617+00:00', '33d5c056-1f17-46e3-bfa8-810400083e24', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."profiles" ("id", "email", "role", "full_name", "created_at", "updated_at", "workshop_id", "phone") VALUES ('e6681028-3cf5-4c31-92a8-9bb2938f3c55', 'dbftradingsng@gmail.com', 'admin_mechanic', 'Victor Ola', '2026-01-13T17:03:38.73094+00:00', '2026-01-13T17:03:38.73094+00:00', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."profiles" ("id", "email", "role", "full_name", "created_at", "updated_at", "workshop_id", "phone") VALUES ('d9b71b6e-2f68-4132-b204-aa8b4b1916a0', 'emiliogala13@gmail.com', 'admin_mechanic', 'Emilio Perez', '2026-01-17T08:27:37.148613+00:00', '2026-01-17T08:27:37.148613+00:00', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."profiles" ("id", "email", "role", "full_name", "created_at", "updated_at", "workshop_id", "phone") VALUES ('e785f3eb-be32-4c2a-81fd-028031bb455b', 'dyd.ialabs@gmail.com', 'admin', 'Alexis Admin', '2026-01-19T18:05:50.796844+00:00', '2026-01-19T18:05:50.796844+00:00', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."profiles" ("id", "email", "role", "full_name", "created_at", "updated_at", "workshop_id", "phone") VALUES ('2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'juanvelasco9888@gmail.com', 'admin_mechanic', 'Juan Velasco', '2025-10-22T20:07:29.198605+00:00', '2025-10-22T20:07:29.198605+00:00', 'c378f51e-ec17-42b6-be0d-142865116848', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."profiles" ("id", "email", "role", "full_name", "created_at", "updated_at", "workshop_id", "phone") VALUES ('485e7cd8-74c1-42e3-bd6b-1cde5ffaeb6b', 'info@expertpericial.com', 'admin_mechanic', 'juan', '2025-10-24T11:58:21.174027+00:00', '2025-10-24T11:58:21.174027+00:00', 'e38941f8-5061-4114-8a2e-cb26f8e1b855', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."profiles" ("id", "email", "role", "full_name", "created_at", "updated_at", "workshop_id", "phone") VALUES ('11c7daf8-8a5e-4537-b6d1-3972c0abbd05', 'alexistomaselli@gmail.com', 'admin_mechanic', 'Taller Alexis', '2025-10-14T00:10:03.767408+00:00', '2025-10-14T00:10:03.767408+00:00', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."profiles" ("id", "email", "role", "full_name", "created_at", "updated_at", "workshop_id", "phone") VALUES ('53107b25-ea1f-42b8-9ed7-f6d55d22127e', 'vmautomocion@hotmail.es', 'admin_mechanic', 'Juan Luis', '2025-10-25T12:34:32.127997+00:00', '2025-10-25T12:34:32.127997+00:00', '303e0a14-a30a-455d-931f-d428d859603a', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."profiles" ("id", "email", "role", "full_name", "created_at", "updated_at", "workshop_id", "phone") VALUES ('08cdb3f5-cd0a-4def-b883-7bae1f269d87', 'javaxtron@gmail.com', 'admin_mechanic', 'Javier fariña rodriguez', '2025-10-25T12:35:51.919942+00:00', '2025-10-25T12:35:51.919942+00:00', '6ad0b598-a6d6-4cdd-99d6-041016b4f704', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."profiles" ("id", "email", "role", "full_name", "created_at", "updated_at", "workshop_id", "phone") VALUES ('8beae8ad-96f9-44aa-b799-b90b1691cd2b', 'tallerescidoncha@hotmail.com', 'admin_mechanic', 'Jose david ruiz', '2025-10-25T12:36:45.73471+00:00', '2025-10-25T12:36:45.73471+00:00', '32a91aea-3e16-4c27-9f13-0a48a153c40d', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."profiles" ("id", "email", "role", "full_name", "created_at", "updated_at", "workshop_id", "phone") VALUES ('f38818fd-e683-4784-9f50-caa90e7f4256', 'talleresribera@hotmail.es', 'admin_mechanic', 'Eva Vázquez Tortajada', '2025-10-25T12:37:47.349417+00:00', '2025-10-25T12:37:47.349417+00:00', 'e2241956-5cc9-4b24-80f1-7566bcd8278e', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."profiles" ("id", "email", "role", "full_name", "created_at", "updated_at", "workshop_id", "phone") VALUES ('b82e8e28-b1e6-468a-8ebc-a77ce99e6744', 'tallerchapicar@gmail.com', 'admin_mechanic', 'Alberto Fariña Rodríguez ', '2025-10-25T12:39:18.959424+00:00', '2025-10-25T12:39:18.959424+00:00', '1681b1c1-1169-4010-883f-f0edb2f8d6e1', NULL) ON CONFLICT DO NOTHING;



-- Data for analysis
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('b2c426c0-90aa-4bc4-8949-f1959cd64d11', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1761336969973_VALORACION%206453MLT.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzYxMzM2OTY5OTczX1ZBTE9SQUNJT04gNjQ1M01MVC5wZGYiLCJpYXQiOjE3NjEzMzY5NzIsImV4cCI6MTc5Mjg3Mjk3Mn0.BQl1Yn6ToIjl7SBvACYcrKDMKnyzsMKAsuheK_9R5jc', 'VALORACION 6453MLT.pdf', 'completed', '2025-10-24', '2025-10-24T20:16:13.288993+00:00', '2025-10-24T20:16:26.671336+00:00', '2024-10-04', 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('763cf1a0-8893-4fcb-8086-330a98dceb4b', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761813990347_VALORACION%203177LNN.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxODEzOTkwMzQ3X1ZBTE9SQUNJT04gMzE3N0xOTi5wZGYiLCJpYXQiOjE3NjE4MTM5OTEsImV4cCI6MTc5MzM0OTk5MX0.1YnIHp43CGfpHf2URoNXKxdiwoOmhWMkMM2NX2yNw3I', 'VALORACION 3177LNN.pdf', 'failed', '2025-10-30', '2025-10-30T08:46:31.338842+00:00', '2025-10-30T08:46:32.274267+00:00', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('025d67fb-1e47-430d-b4d2-0026906f066e', '95eaba1c-5e43-4be5-8a48-e90e58b42cd0', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/95eaba1c-5e43-4be5-8a48-e90e58b42cd0/1761367785512_VALORACION%206453MLT.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzk1ZWFiYTFjLTVlNDMtNGJlNS04YTQ4LWU5MGU1OGI0MmNkMC8xNzYxMzY3Nzg1NTEyX1ZBTE9SQUNJT04gNjQ1M01MVC5wZGYiLCJpYXQiOjE3NjEzNjc3ODQsImV4cCI6MTc5MjkwMzc4NH0.ogxtrehJ8mXJhKTkvvdJjM8SEuLvaVcoMmB303qV4zE', 'VALORACION 6453MLT.pdf', 'completed', '2025-10-25', '2025-10-25T04:49:44.935628+00:00', '2025-10-25T04:49:56.580469+00:00', '2024-10-04', '83899a7d-7f95-4033-aa91-71cb0b9ecdbf') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('8eb539f0-73b2-472c-87d4-e7b5d2f5109a', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761368906786_VALORACION%206453MLT.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxMzY4OTA2Nzg2X1ZBTE9SQUNJT04gNjQ1M01MVC5wZGYiLCJpYXQiOjE3NjEzNjg5MDYsImV4cCI6MTc5MjkwNDkwNn0.TWX53Mj7v2G2ZB5HVr3Gep47XKlFV9So7bHzRpHUOME', 'VALORACION 6453MLT.pdf', 'completed', '2025-10-25', '2025-10-25T05:08:26.695625+00:00', '2025-10-25T05:08:31.353346+00:00', '2024-10-04', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('3bfcffa4-bf71-4244-9474-264dede4294d', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761814659638_VALORACION%206078GGM.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxODE0NjU5NjM4X1ZBTE9SQUNJT04gNjA3OEdHTS5wZGYiLCJpYXQiOjE3NjE4MTQ2NjAsImV4cCI6MTc5MzM1MDY2MH0.d0S022LoRCc15yxsprhhp12cxSsP2hVluqeRPXcvmV4', 'VALORACION 6078GGM.pdf', 'failed', '2025-10-30', '2025-10-30T08:57:40.416401+00:00', '2025-10-30T08:57:41.475117+00:00', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('bac69b7f-0741-4c3c-b15f-f1d5fb26c475', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1761392724611_VALORACION%206453MLT.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzYxMzkyNzI0NjExX1ZBTE9SQUNJT04gNjQ1M01MVC5wZGYiLCJpYXQiOjE3NjEzOTI3MjcsImV4cCI6MTc5MjkyODcyN30.DV9AlWdwzYHBXLul74gRNcd6HzRKOnjOG73c8400fIU', 'VALORACION 6453MLT.pdf', 'completed', '2025-10-25', '2025-10-25T11:45:27.661422+00:00', '2025-10-25T11:45:39.738841+00:00', '2024-10-04', 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('81caf459-9bfa-4800-a09b-20b63ad3eeb2', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1761831356991_VALORACION%206078GGM%20(1).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzYxODMxMzU2OTkxX1ZBTE9SQUNJT04gNjA3OEdHTSAoMSkucGRmIiwiaWF0IjoxNzYxODMxMzYzLCJleHAiOjE3OTMzNjczNjN9.KJ6mBiuxL-2jEhT0p0I2M6vR9FWrmab27HlynsARQMk', 'VALORACION 6078GGM (1).pdf', 'completed', '2025-10-30', '2025-10-30T13:36:03.778215+00:00', '2025-10-30T13:36:12.796903+00:00', '2024-06-03', 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('8bd49f48-af6c-4257-a055-697abf4de5e8', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1761394713043_VALORACION%206453MLT.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzYxMzk0NzEzMDQzX1ZBTE9SQUNJT04gNjQ1M01MVC5wZGYiLCJpYXQiOjE3NjEzOTQ3MTUsImV4cCI6MTc5MjkzMDcxNX0.yzjDhi5xz-2vXAFHM-umjFub3HtPLgwo9JLDKf9WcFE', 'VALORACION 6453MLT.pdf', 'completed', '2025-10-25', '2025-10-25T12:18:36.079613+00:00', '2025-10-25T12:18:42.342924+00:00', '2024-10-04', 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('761d4e93-6d8f-4747-aaa2-73cf16dafb14', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1761395565099_VALORACION%206453MLT.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzYxMzk1NTY1MDk5X1ZBTE9SQUNJT04gNjQ1M01MVC5wZGYiLCJpYXQiOjE3NjEzOTU1NjcsImV4cCI6MTc5MjkzMTU2N30.T8Or61qvlXiJiZ1pAydJb_SCMvwZkY2x1E3K4jh11Ks', 'VALORACION 6453MLT.pdf', 'completed', '2025-10-25', '2025-10-25T12:32:48.465387+00:00', '2025-10-25T12:32:54.416332+00:00', '2024-10-04', 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('8223a51f-6018-41a7-a747-88eaa833b136', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1761396894055_VALORACION%206078GGM%20(1).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzYxMzk2ODk0MDU1X1ZBTE9SQUNJT04gNjA3OEdHTSAoMSkucGRmIiwiaWF0IjoxNzYxMzk2ODk3LCJleHAiOjE3OTI5MzI4OTd9.UUyeo8xpI5mzXzlMNw5pG-oFdoeT7Ac_Xm7Xt9ShM8E', 'VALORACION 6078GGM (1).pdf', 'completed', '2025-10-25', '2025-10-25T12:54:57.837634+00:00', '2025-10-25T12:55:07.312816+00:00', '2024-06-03', 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('d1d0fc4c-e178-47ab-8fbd-0df854afae31', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761563699810_VALORACION%206453MLT.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxNTYzNjk5ODEwX1ZBTE9SQUNJT04gNjQ1M01MVC5wZGYiLCJpYXQiOjE3NjE1NjM2OTksImV4cCI6MTc5MzA5OTY5OX0.ijRYlyPsN4qo0703XG8LUIwBxENj2fqu9K5_pp0fAvs', 'VALORACION 6453MLT.pdf', 'completed', '2025-10-27', '2025-10-27T11:15:00.109015+00:00', '2025-10-27T11:15:10.529448+00:00', '2024-10-04', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('5f2bdcd7-7262-4bf4-91b8-e1b02dd14e70', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761640112771_VALORACION%202996HDN.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxNjQwMTEyNzcxX1ZBTE9SQUNJT04gMjk5NkhETi5wZGYiLCJpYXQiOjE3NjE2NDAxMTEsImV4cCI6MTc5MzE3NjExMX0.wqn7vetdGv6CZ55N1w3Om9-cCgE5yvTh_wXUobPXHiE', 'VALORACION 2996HDN.pdf', 'completed', '2025-10-28', '2025-10-28T08:28:31.720177+00:00', '2025-10-28T08:28:37.553743+00:00', '2025-02-20', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('c012c32e-3cf6-4939-9f98-ef9dcb706e2b', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1761337947220_VALORACION%206453MLT.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzYxMzM3OTQ3MjIwX1ZBTE9SQUNJT04gNjQ1M01MVC5wZGYiLCJpYXQiOjE3NjEzMzc5NTAsImV4cCI6MTc5Mjg3Mzk1MH0.OGHbOo8FkvrX6WBBUPMOhoplkdpjYJQIC2IyZ-DNVpY', 'VALORACION 6453MLT.pdf', 'completed', '2025-10-24', '2025-10-24T20:32:30.786151+00:00', '2025-10-24T20:32:44.303954+00:00', '2024-10-04', 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('c239da67-cffd-44c2-a5a7-8a6732678309', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761814554904_VALORACION%209763JYM.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxODE0NTU0OTA0X1ZBTE9SQUNJT04gOTc2M0pZTS5wZGYiLCJpYXQiOjE3NjE4MTQ1NTYsImV4cCI6MTc5MzM1MDU1Nn0.iUH7EOSC7MtWV8l33I38k1zzRGUKgbwfvPz5U4fNOq8', 'VALORACION 9763JYM.pdf', 'failed', '2025-10-30', '2025-10-30T08:55:56.989245+00:00', '2025-10-30T08:55:58.515307+00:00', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('151c5507-c5bf-4fc7-ade9-7b93b83861dc', '95eaba1c-5e43-4be5-8a48-e90e58b42cd0', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/95eaba1c-5e43-4be5-8a48-e90e58b42cd0/1761368080195_VALORACION%206453MLT.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzk1ZWFiYTFjLTVlNDMtNGJlNS04YTQ4LWU5MGU1OGI0MmNkMC8xNzYxMzY4MDgwMTk1X1ZBTE9SQUNJT04gNjQ1M01MVC5wZGYiLCJpYXQiOjE3NjEzNjgwNzksImV4cCI6MTc5MjkwNDA3OX0.fem-jDkNYrFffd2FOtXumW6WUsVkRqD1VCZoLw00ML4', 'VALORACION 6453MLT.pdf', 'completed', '2025-10-25', '2025-10-25T04:54:39.43359+00:00', '2025-10-25T04:54:44.836538+00:00', '2024-10-04', '83899a7d-7f95-4033-aa91-71cb0b9ecdbf') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('f7f170b1-b589-49cc-9a74-1378c2a84a47', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761368960024_VALORACION%206453MLT.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxMzY4OTYwMDI0X1ZBTE9SQUNJT04gNjQ1M01MVC5wZGYiLCJpYXQiOjE3NjEzNjg5NTksImV4cCI6MTc5MjkwNDk1OX0.itxZbJvmiYdlodn74mtjXqVEN3IqLG_OoaGjZC38ClE', 'VALORACION 6453MLT.pdf', 'completed', '2025-10-25', '2025-10-25T05:09:19.565855+00:00', '2025-10-25T05:10:26.084268+00:00', '2024-10-04', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('c68aa54b-d891-4125-9afb-817b1ae28500', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1761831200318_VALORACION%206078GGM%20(1).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzYxODMxMjAwMzE4X1ZBTE9SQUNJT04gNjA3OEdHTSAoMSkucGRmIiwiaWF0IjoxNzYxODMxMjA0LCJleHAiOjE3OTMzNjcyMDR9.OxvgNtY0B2-5xMOwJ48w-m6LYF7RtEe1dPuMxHytUgI', 'VALORACION 6078GGM (1).pdf', 'failed', '2025-10-30', '2025-10-30T13:33:25.074642+00:00', '2025-10-30T13:33:30.143243+00:00', NULL, 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('3dadd1da-b2da-4cac-b21d-28b10658b2bc', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1761393149852_VALORACION%206453MLT.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzYxMzkzMTQ5ODUyX1ZBTE9SQUNJT04gNjQ1M01MVC5wZGYiLCJpYXQiOjE3NjEzOTMxNTIsImV4cCI6MTc5MjkyOTE1Mn0.WSHfIBKqA3uim4Fr6iF7OvhUeFHuE-HEgguzRBXmGrA', 'VALORACION 6453MLT.pdf', 'completed', '2025-10-25', '2025-10-25T11:52:33.042066+00:00', '2025-10-25T11:52:40.66371+00:00', '2024-10-04', 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('9eecc801-d9a1-4aaa-8f6d-dd0b0f3cffa1', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761395053957_VALORACION%206453MLT.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxMzk1MDUzOTU3X1ZBTE9SQUNJT04gNjQ1M01MVC5wZGYiLCJpYXQiOjE3NjEzOTUwNTMsImV4cCI6MTc5MjkzMTA1M30.r981kgjj2_BYYiOYqoBolNgnfPUsgp6xvpFKkSFtlxo', 'VALORACION 6453MLT.pdf', 'completed', '2025-10-25', '2025-10-25T12:24:14.418538+00:00', '2025-10-25T12:25:35.917015+00:00', '2024-10-04', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('c9e852a0-cf25-4af0-a367-b04128e1754e', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1761395742729_VALORACION%206078GGM%20(1).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzYxMzk1NzQyNzI5X1ZBTE9SQUNJT04gNjA3OEdHTSAoMSkucGRmIiwiaWF0IjoxNzYxMzk1NzQ2LCJleHAiOjE3OTI5MzE3NDZ9.uP5LTcGwPvo5YHM9pEp2PtCpv36Bmtx7je4U62iK7Lg', 'VALORACION 6078GGM (1).pdf', 'completed', '2025-10-25', '2025-10-25T12:35:46.396995+00:00', '2025-10-25T12:35:55.073557+00:00', '2024-06-03', 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('5eaf394f-8b36-46f6-9f87-deb04ef07ffc', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1761526819431_VALORACION%206078GGM%20(1).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzYxNTI2ODE5NDMxX1ZBTE9SQUNJT04gNjA3OEdHTSAoMSkucGRmIiwiaWF0IjoxNzYxNTI2ODIzLCJleHAiOjE3OTMwNjI4MjN9.0e_Nk9_MDMe298f_dc2MUzy0bpdFcHbmQDlU2SU4duI', 'VALORACION 6078GGM (1).pdf', 'completed', '2025-10-27', '2025-10-27T01:00:24.03918+00:00', '2025-10-27T01:00:33.088929+00:00', '2024-06-03', 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('a49c9617-8c50-4bdc-b758-757cef41da85', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761564080630_VALORACION%206453MLT.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxNTY0MDgwNjMwX1ZBTE9SQUNJT04gNjQ1M01MVC5wZGYiLCJpYXQiOjE3NjE1NjQwODAsImV4cCI6MTc5MzEwMDA4MH0.qseunpVDsmwswxDovbtcp3qPAvV1OhM34XQ_0rNb2mA', 'VALORACION 6453MLT.pdf', 'completed', '2025-10-27', '2025-10-27T11:21:20.900385+00:00', '2025-10-27T11:21:24.750193+00:00', '2024-10-04', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('91163696-5e80-4849-ad0a-d6ad7759fa5d', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761813907410_VALORACION%203177LNN.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxODEzOTA3NDEwX1ZBTE9SQUNJT04gMzE3N0xOTi5wZGYiLCJpYXQiOjE3NjE4MTM5MDgsImV4cCI6MTc5MzM0OTkwOH0.W2y5TbYuypPTJkmyHpniOV-iLso5dVNFyfdQlBQPydA', 'VALORACION 3177LNN.pdf', 'failed', '2025-10-30', '2025-10-30T08:45:08.579464+00:00', '2025-10-30T08:45:10.544394+00:00', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('82e22b6c-60ad-4aea-9408-c30db11761c9', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761813929775_VALORACION%203177LNN.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxODEzOTI5Nzc1X1ZBTE9SQUNJT04gMzE3N0xOTi5wZGYiLCJpYXQiOjE3NjE4MTM5MzAsImV4cCI6MTc5MzM0OTkzMH0.SRS8JUYX-oEkhiuPcj15fG5rRNjMTBtAnPHoLMXiICo', 'VALORACION 3177LNN.pdf', 'failed', '2025-10-30', '2025-10-30T08:45:30.797724+00:00', '2025-10-30T08:45:32.046449+00:00', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('aee6539b-0a5c-4839-a50c-3e12b5589946', '95eaba1c-5e43-4be5-8a48-e90e58b42cd0', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/95eaba1c-5e43-4be5-8a48-e90e58b42cd0/1761367748244_WEB%20TRAFFIC%20CLAIMS.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzk1ZWFiYTFjLTVlNDMtNGJlNS04YTQ4LWU5MGU1OGI0MmNkMC8xNzYxMzY3NzQ4MjQ0X1dFQiBUUkFGRklDIENMQUlNUy5wZGYiLCJpYXQiOjE3NjEzNjc3NDcsImV4cCI6MTc5MjkwMzc0N30.BKsAHWBse62tF5ha27uL1uOQlAa8HTyy7TtJIxFzDZI', 'WEB TRAFFIC CLAIMS.pdf', 'failed', '2025-10-25', '2025-10-25T04:49:08.140493+00:00', '2025-10-25T04:49:09.778604+00:00', NULL, '83899a7d-7f95-4033-aa91-71cb0b9ecdbf') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('37a438aa-ebd9-458c-b63c-cfceb2e1a4f4', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761814564962_7860LZY%20VALORACION.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxODE0NTY0OTYyXzc4NjBMWlkgVkFMT1JBQ0lPTi5wZGYiLCJpYXQiOjE3NjE4MTQ1NjUsImV4cCI6MTc5MzM1MDU2NX0.o8P6ob4-ntoQyKnxrqWNlxSJKF1I7zhIFkbOrox-yF4', '7860LZY VALORACION.pdf', 'failed', '2025-10-30', '2025-10-30T08:56:05.34141+00:00', '2025-10-30T08:56:06.418372+00:00', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('d5daf860-cd18-4371-9f47-9a765b9fc160', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761368592455_VALORACION%206453MLT.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxMzY4NTkyNDU1X1ZBTE9SQUNJT04gNjQ1M01MVC5wZGYiLCJpYXQiOjE3NjEzNjg1OTIsImV4cCI6MTc5MjkwNDU5Mn0.7jn3Oo3T0O58Dga2ktIRXCP6knxc7onV4it1cDjapWQ', 'VALORACION 6453MLT.pdf', 'completed', '2025-10-25', '2025-10-25T05:03:12.627024+00:00', '2025-10-25T05:03:23.694839+00:00', '2024-10-04', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('527f74fc-c9a9-4864-b934-2db6e45b059a', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761826424500_VALORACION%203177LNN.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxODI2NDI0NTAwX1ZBTE9SQUNJT04gMzE3N0xOTi5wZGYiLCJpYXQiOjE3NjE4MjY0MjUsImV4cCI6MTc5MzM2MjQyNX0.P2SGvA_Fpa7isCh1uxl_H4JaD1Zy0X5jFyeMiODWryc', 'VALORACION 3177LNN.pdf', 'failed', '2025-10-30', '2025-10-30T12:13:45.546773+00:00', '2025-10-30T12:13:47.473923+00:00', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('5ed19d5c-7d5d-4a49-a05f-f13477b20d9e', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761369144667_VALORACION%206453MLT.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxMzY5MTQ0NjY3X1ZBTE9SQUNJT04gNjQ1M01MVC5wZGYiLCJpYXQiOjE3NjEzNjkxNDQsImV4cCI6MTc5MjkwNTE0NH0.NP9_4-DeJeHKbVpelA2KGcoHkKg8vuejamOHa-EeS3E', 'VALORACION 6453MLT.pdf', 'completed', '2025-10-25', '2025-10-25T05:12:24.553914+00:00', '2025-10-25T05:14:19.220934+00:00', '2024-10-04', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('3af195dd-efcb-4f7d-aa88-8eadda5ee2ea', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1761394472923_VALORACION%206453MLT.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzYxMzk0NDcyOTIzX1ZBTE9SQUNJT04gNjQ1M01MVC5wZGYiLCJpYXQiOjE3NjEzOTQ0NzUsImV4cCI6MTc5MjkzMDQ3NX0.ggd2Ec1GPxN8PN7zp7BD1QLEnUvzi-Q4kuq2z1pVKIU', 'VALORACION 6453MLT.pdf', 'completed', '2025-10-25', '2025-10-25T12:14:36.153884+00:00', '2025-10-25T12:14:47.440893+00:00', '2024-10-04', 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('1eaab974-3d0c-47e8-b256-092546805966', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761395307836_VALORACION%206453MLT.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxMzk1MzA3ODM2X1ZBTE9SQUNJT04gNjQ1M01MVC5wZGYiLCJpYXQiOjE3NjEzOTUzMDcsImV4cCI6MTc5MjkzMTMwN30.UkXwvnlTIjUxqXbsL5H7OTmwNvyhIuXVHgp1GRHHZlE', 'VALORACION 6453MLT.pdf', 'completed', '2025-10-25', '2025-10-25T12:28:28.007974+00:00', '2025-10-25T12:30:17.454834+00:00', '2024-10-04', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('08adf655-1ad7-44df-a9c6-05ff83b61f82', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1761396288164_VALORACION%206078GGM%20(1).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzYxMzk2Mjg4MTY0X1ZBTE9SQUNJT04gNjA3OEdHTSAoMSkucGRmIiwiaWF0IjoxNzYxMzk2MjkxLCJleHAiOjE3OTI5MzIyOTF9.o3hElkxA54fCmkgHqXuUHb89dKF2fxXUEWUIE2YG-L0', 'VALORACION 6078GGM (1).pdf', 'completed', '2025-10-25', '2025-10-25T12:44:52.225146+00:00', '2025-10-25T12:45:00.995415+00:00', '2024-06-03', 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('65e8c60b-7b0b-437e-bde4-528ea472038d', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761558416408_VALORACION%206453MLT.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxNTU4NDE2NDA4X1ZBTE9SQUNJT04gNjQ1M01MVC5wZGYiLCJpYXQiOjE3NjE1NTg0MTYsImV4cCI6MTc5MzA5NDQxNn0.ew8OcXbiBQM_raRIw3qiJcy-GF7s-Afsf63Ve4xWuIo', 'VALORACION 6453MLT.pdf', 'completed', '2025-10-27', '2025-10-27T09:46:56.545469+00:00', '2025-10-27T09:47:07.930637+00:00', '2024-10-04', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('a5d85a2d-364c-4500-9192-6cbeac8c3e3e', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761639535198_VALORACION%202996HDN.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxNjM5NTM1MTk4X1ZBTE9SQUNJT04gMjk5NkhETi5wZGYiLCJpYXQiOjE3NjE2Mzk1MzMsImV4cCI6MTc5MzE3NTUzM30.AYsSQyMyMw0pYl4HU-KlxUI22XJLZzkkxZK3l1fQMYQ', 'VALORACION 2996HDN.pdf', 'completed', '2025-10-28', '2025-10-28T08:18:53.997318+00:00', '2025-10-28T08:19:07.781083+00:00', '2025-02-20', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('dfcefd25-f74c-4a8b-9269-8bf36f4e46c7', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761813969121_VALORACION%203177LNN.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxODEzOTY5MTIxX1ZBTE9SQUNJT04gMzE3N0xOTi5wZGYiLCJpYXQiOjE3NjE4MTM5NzAsImV4cCI6MTc5MzM0OTk3MH0.c0GXPV84qWBQo-qMM7fb2WZyYjGlaSTuWPOKG2pNObk', 'VALORACION 3177LNN.pdf', 'failed', '2025-10-30', '2025-10-30T08:46:10.349053+00:00', '2025-10-30T08:46:11.575092+00:00', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('8bdf9786-763f-45d4-82cc-b1ba3f166bf3', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1761837248413_VALORACION%206078GGM%20(1).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzYxODM3MjQ4NDEzX1ZBTE9SQUNJT04gNjA3OEdHTSAoMSkucGRmIiwiaWF0IjoxNzYxODM3MjUyLCJleHAiOjE3OTMzNzMyNTJ9.teA-kzCgQ6BPMqMhtIs9BlXskJ9zblUbPitJWd0lHQg', 'VALORACION 6078GGM (1).pdf', 'failed', '2025-10-30', '2025-10-30T15:14:12.876937+00:00', '2025-10-30T15:14:17.718044+00:00', NULL, 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('0e00348e-76ea-43d8-9fcc-5957a6e40b55', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1761838024119_VALORACION%206078GGM%20(1).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzYxODM4MDI0MTE5X1ZBTE9SQUNJT04gNjA3OEdHTSAoMSkucGRmIiwiaWF0IjoxNzYxODM4MDI3LCJleHAiOjE3OTMzNzQwMjd9.zSkJlbB06bTs2pkjzPXapf273et_X2laZ1xA_m5dVag', 'VALORACION 6078GGM (1).pdf', 'failed', '2025-10-30', '2025-10-30T15:27:08.093159+00:00', '2025-10-30T15:27:12.946799+00:00', NULL, 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('0d6ef303-ec74-4446-b969-c56787e48980', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1761838581649_VALORACION%206078GGM%20(1).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzYxODM4NTgxNjQ5X1ZBTE9SQUNJT04gNjA3OEdHTSAoMSkucGRmIiwiaWF0IjoxNzYxODM4NTg1LCJleHAiOjE3OTMzNzQ1ODV9.8lrE9mZhRWOi4ZmFI0uo6qRbwiZqRgetZqbVn5aJF5o', 'VALORACION 6078GGM (1).pdf', 'completed', '2025-10-30', '2025-10-30T15:36:26.036297+00:00', '2025-10-30T15:36:39.372043+00:00', '2024-06-03', 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('995fde9b-dbb7-4cd0-8d7a-1a01f2f876a6', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1761838683305_VALORACION%206078GGM%20(1).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzYxODM4NjgzMzA1X1ZBTE9SQUNJT04gNjA3OEdHTSAoMSkucGRmIiwiaWF0IjoxNzYxODM4Njk1LCJleHAiOjE3OTMzNzQ2OTV9.TYac7B2KC0Ajii9ZJaYlMhqcr6aYE6xeg48aNqIEJb4', 'VALORACION 6078GGM (1).pdf', 'failed', '2025-10-30', '2025-10-30T15:38:15.985678+00:00', '2025-10-30T15:38:20.765599+00:00', NULL, 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('113c6a12-7ad7-46d4-8cda-684cd19807e1', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761839701477_VALORACION%209763JYM.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxODM5NzAxNDc3X1ZBTE9SQUNJT04gOTc2M0pZTS5wZGYiLCJpYXQiOjE3NjE4Mzk3MDMsImV4cCI6MTc5MzM3NTcwM30.8EyJrcHysIZGCnq6GmMCwKrHT7CE5zp8X-E1CP5Cjn8', 'VALORACION 9763JYM.pdf', 'failed', '2025-10-30', '2025-10-30T15:55:03.911011+00:00', '2025-10-30T15:55:05.864363+00:00', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('6cb254cd-2857-4a5a-bdac-7ee87d27c8e7', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1761844092696_VALORACION%206078GGM%20(1).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzYxODQ0MDkyNjk2X1ZBTE9SQUNJT04gNjA3OEdHTSAoMSkucGRmIiwiaWF0IjoxNzYxODQ0MDk2LCJleHAiOjE3OTMzODAwOTZ9.KXB3bQm0FKvg_ZzFZ3f4klph4XqIY4a7usIbRRp4t0I', 'VALORACION 6078GGM (1).pdf', 'failed', '2025-10-30', '2025-10-30T17:08:17.175211+00:00', '2025-10-30T17:08:21.697593+00:00', NULL, 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('4c8afcd0-106d-4b98-ae74-1c9510559375', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1761844415265_VALORACION%206078GGM%20(1).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzYxODQ0NDE1MjY1X1ZBTE9SQUNJT04gNjA3OEdHTSAoMSkucGRmIiwiaWF0IjoxNzYxODQ0NDE5LCJleHAiOjE3OTMzODA0MTl9.vRLyFw1ipZ91kF3zPIrPpLf8-dWGDpffqqOTL_qObAM', 'VALORACION 6078GGM (1).pdf', 'completed', '2025-10-30', '2025-10-30T17:13:39.592649+00:00', '2025-10-30T17:13:52.746565+00:00', '2024-06-03', 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('bc001503-bb09-489a-8325-597b975ae818', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1761844517521_VALORACION%206078GGM%20(1).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzYxODQ0NTE3NTIxX1ZBTE9SQUNJT04gNjA3OEdHTSAoMSkucGRmIiwiaWF0IjoxNzYxODQ0NTIxLCJleHAiOjE3OTMzODA1MjF9.oaTKwwh68WY0pfGgru9TTnarFDChfvxmy4J2FiXFSj8', 'VALORACION 6078GGM (1).pdf', 'completed', '2025-10-30', '2025-10-30T17:15:21.563248+00:00', '2025-10-30T17:15:32.48882+00:00', '2024-06-03', 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('10dc352c-a7db-412b-bb75-3a3879b7839b', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761852755056_VALORACION%203177LNN.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxODUyNzU1MDU2X1ZBTE9SQUNJT04gMzE3N0xOTi5wZGYiLCJpYXQiOjE3NjE4NTI3NTQsImV4cCI6MTc5MzM4ODc1NH0.WyJaERoT2m3GOuI5j2tBKnzRjqgfgWNE5HTnJ3fRBQ8', 'VALORACION 3177LNN.pdf', 'completed', '2025-10-30', '2025-10-30T19:32:35.475123+00:00', '2025-10-30T19:32:44.605542+00:00', '2023-10-31', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('411c4f4d-5d65-4742-bac6-e39209d2b057', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1761852894909_VALORACION%203177LNN.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYxODUyODk0OTA5X1ZBTE9SQUNJT04gMzE3N0xOTi5wZGYiLCJpYXQiOjE3NjE4NTI4OTQsImV4cCI6MTc5MzM4ODg5NH0.HyVqdywPowl-8fA7GX-oI8b6FTrcp4qGc074tJhAths', 'VALORACION 3177LNN.pdf', 'completed', '2025-10-30', '2025-10-30T19:34:55.128716+00:00', '2025-10-30T19:37:08.194334+00:00', '2023-07-13', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('00732566-2c92-4439-b0d1-a5dc224e9985', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1762162010473_Copia%20de%20VALORACION%202384LCH.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYyMTYyMDEwNDczX0NvcGlhIGRlIFZBTE9SQUNJT04gMjM4NExDSC5wZGYiLCJpYXQiOjE3NjIxNjIwMTEsImV4cCI6MTc5MzY5ODAxMX0.tXHU3Qzu7Ld14ullw644DAw8JPVojgZWwjp7Zapu4o8', 'Copia de VALORACION 2384LCH.pdf', 'completed', '2025-11-03', '2025-11-03T09:26:52.213975+00:00', '2025-11-03T09:32:04.024419+00:00', '2024-04-19', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('32ecf060-c119-406b-8ba9-b529c9635484', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1762508774854_VALORACION%209763JYM%20(2).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYyNTA4Nzc0ODU0X1ZBTE9SQUNJT04gOTc2M0pZTSAoMikucGRmIiwiaWF0IjoxNzYyNTA4Nzc2LCJleHAiOjE3OTQwNDQ3NzZ9.PvLdU7l2M3z1wGmI2ys6C3h_TGQDWqEZ3GZcGpxqSDU', 'VALORACION 9763JYM (2).pdf', 'completed', '2025-11-07', '2025-11-07T09:46:16.621729+00:00', '2025-11-07T09:48:25.829216+00:00', '2024-06-20', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('c356fb28-ff3f-43ca-890c-f22324567222', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1762163823093_Copia%20de%20VALORACION%202384LCH.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYyMTYzODIzMDkzX0NvcGlhIGRlIFZBTE9SQUNJT04gMjM4NExDSC5wZGYiLCJpYXQiOjE3NjIxNjM4MjQsImV4cCI6MTc5MzY5OTgyNH0.4jhi-1EYTDedJgs4-lyqRnQXGxKJZ52eU-T7aBsMAU4', 'Copia de VALORACION 2384LCH.pdf', 'completed', '2025-11-03', '2025-11-03T09:57:05.219911+00:00', '2025-11-03T09:59:50.554683+00:00', '2024-04-19', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('5fb11745-72b3-47a7-9e76-01a1ec583ddb', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1762339943382_VALORACION%208062JWG%20-%2069.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYyMzM5OTQzMzgyX1ZBTE9SQUNJT04gODA2MkpXRyAtIDY5LnBkZiIsImlhdCI6MTc2MjMzOTk1MCwiZXhwIjoxNzkzODc1OTUwfQ.YXCzERZ7pXH5RSmJE1GHC_Mt_iyMX87wv-DebDL3Iyk', 'VALORACION 8062JWG - 69.pdf', 'completed', '2025-11-05', '2025-11-05T10:52:30.858651+00:00', '2025-11-05T10:52:37.674271+00:00', '2024-11-19', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('ffc87a99-b310-48c1-8a15-bd0bac2d3b93', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1762339952439_VALORACION%208062JWG%20-%2032.5.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYyMzM5OTUyNDM5X1ZBTE9SQUNJT04gODA2MkpXRyAtIDMyLjUucGRmIiwiaWF0IjoxNzYyMzM5OTU5LCJleHAiOjE3OTM4NzU5NTl9.xoOew7UywFCGSrVfDxb9ZBX5TSiozpZ7cczniMThX_E', 'VALORACION 8062JWG - 32.5.pdf', 'completed', '2025-11-05', '2025-11-05T10:52:40.189541+00:00', '2025-11-05T10:52:53.171693+00:00', '2024-11-19', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('2bc90494-ace8-405b-8090-2a2aca5b0d99', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1762340034874_VALORACION%208062JWG%20-%2032.5.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYyMzQwMDM0ODc0X1ZBTE9SQUNJT04gODA2MkpXRyAtIDMyLjUucGRmIiwiaWF0IjoxNzYyMzQwMDQyLCJleHAiOjE3OTM4NzYwNDJ9.5r3xfIvUnYlt8HIJ_WJMDnBLAjLbUJ5EcePCA6TpXJE', 'VALORACION 8062JWG - 32.5.pdf', 'completed', '2025-11-05', '2025-11-05T10:54:02.553445+00:00', '2025-11-05T10:56:42.275584+00:00', '2024-11-19', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('b343a3b4-1a75-4e5a-b336-f25a1fddfa1e', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1762509452684_VALORACION%209763JYM%20(2).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYyNTA5NDUyNjg0X1ZBTE9SQUNJT04gOTc2M0pZTSAoMikucGRmIiwiaWF0IjoxNzYyNTA5NDU0LCJleHAiOjE3OTQwNDU0NTR9.ThLlz2Q5b1rQ2NmUQEGhHlMq7lrXxcvwWkAVD5Cj_ag', 'VALORACION 9763JYM (2).pdf', 'completed', '2025-11-07', '2025-11-07T09:57:34.602815+00:00', '2025-11-07T09:57:40.720824+00:00', '2024-06-20', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('746c2bc5-0672-4178-9984-1f6c9a4435d4', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1762509853027_VALORACION%209763JYM%20(2).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYyNTA5ODUzMDI3X1ZBTE9SQUNJT04gOTc2M0pZTSAoMikucGRmIiwiaWF0IjoxNzYyNTA5ODU1LCJleHAiOjE3OTQwNDU4NTV9.AY6HLTCQdrJU9GGH_ggSxl2aihlVxELQ3Oqcm3drDRA', 'VALORACION 9763JYM (2).pdf', 'completed', '2025-11-07', '2025-11-07T10:04:15.94973+00:00', '2025-11-07T10:04:22.061096+00:00', '2024-06-20', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('c15703ca-50d0-46eb-bcf9-54692df84492', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1762937053658_INFORME%207782JMY.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYyOTM3MDUzNjU4X0lORk9STUUgNzc4MkpNWS5wZGYiLCJpYXQiOjE3NjI5MzcwNTksImV4cCI6MTc5NDQ3MzA1OX0.FZB72XJ2TVvH9n-QKQl2L4gMo2ZTnd6Dt8JCc7AngIo', 'INFORME 7782JMY.pdf', 'completed', '2025-11-12', '2025-11-12T08:44:20.013111+00:00', '2025-11-12T08:44:25.348299+00:00', '2024-11-07', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('6df31cac-1ff0-4dd1-ab6c-7fd437a70528', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1762937117341_INFORME%207782JMY.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYyOTM3MTE3MzQxX0lORk9STUUgNzc4MkpNWS5wZGYiLCJpYXQiOjE3NjI5MzcxMjMsImV4cCI6MTc5NDQ3MzEyM30.mkdsvEy27RpDBm4e18ZvLKq_To0UKF-4EM2taqS8CKE', 'INFORME 7782JMY.pdf', 'completed', '2025-11-12', '2025-11-12T08:45:23.665994+00:00', '2025-11-12T08:50:53.234703+00:00', '2024-09-03', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('810583fe-81b0-4146-ade7-7b6356dddded', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1762938390377_INFORME%207782JMY.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYyOTM4MzkwMzc3X0lORk9STUUgNzc4MkpNWS5wZGYiLCJpYXQiOjE3NjI5MzgzOTYsImV4cCI6MTc5NDQ3NDM5Nn0.KQkTEeo_FjToCePFTx2lH9_TDOBtPMcNa0C9VlW0sPQ', 'INFORME 7782JMY.pdf', 'completed', '2025-11-12', '2025-11-12T09:06:36.482461+00:00', '2025-11-12T09:10:30.799284+00:00', '2024-09-03', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('7725d35f-3e18-4e28-8e27-463a878f33cf', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1763109466749_VALORACION%207824GSL%20(1).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYzMTA5NDY2NzQ5X1ZBTE9SQUNJT04gNzgyNEdTTCAoMSkucGRmIiwiaWF0IjoxNzYzMTA5NDY4LCJleHAiOjE3OTQ2NDU0Njh9.4T4me8rFGltkxOq2P2O6mr1nWG7sfoSaqlLG-8g3yA4', 'VALORACION 7824GSL (1).pdf', 'completed', '2025-11-14', '2025-11-14T08:37:48.597187+00:00', '2025-11-14T08:37:57.955895+00:00', '2023-04-05', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('650e7146-94b7-490c-b06b-4ca6e4c047e0', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1763109986990_VALORACION%207824GSL%20(1).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYzMTA5OTg2OTkwX1ZBTE9SQUNJT04gNzgyNEdTTCAoMSkucGRmIiwiaWF0IjoxNzYzMTA5OTg4LCJleHAiOjE3OTQ2NDU5ODh9.pdUmDf6YQNImOMMK62SQBwJwTjNC_rnBs8FcxMZYmMM', 'VALORACION 7824GSL (1).pdf', 'completed', '2025-11-14', '2025-11-14T08:46:28.405165+00:00', '2025-11-14T08:46:33.461113+00:00', '2023-04-05', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('671a884b-d938-40c4-9b01-13f0bd7453a8', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1763110084815_VALORACION%207824GSL%20(1).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzYzMTEwMDg0ODE1X1ZBTE9SQUNJT04gNzgyNEdTTCAoMSkucGRmIiwiaWF0IjoxNzYzMTEwMDg2LCJleHAiOjE3OTQ2NDYwODZ9.u0WicBFGsY5vIyijoJUb8LtzZf4hSgqQhmPlTeZdUrI', 'VALORACION 7824GSL (1).pdf', 'completed', '2025-11-14', '2025-11-14T08:48:07.205831+00:00', '2025-11-14T08:48:14.311911+00:00', '2023-04-05', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('1bee2256-f79f-4dcd-ac6e-25f860126e5c', 'b0c73890-3fdf-49f2-b4af-29530c8ad59a', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/b0c73890-3fdf-49f2-b4af-29530c8ad59a/1765233263629_EnrollmentAgreement1.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzL2IwYzczODkwLTNmZGYtNDlmMi1iNGFmLTI5NTMwYzhhZDU5YS8xNzY1MjMzMjYzNjI5X0Vucm9sbG1lbnRBZ3JlZW1lbnQxLnBkZiIsImlhdCI6MTc2NTIzMzI2NSwiZXhwIjoxNzk2NzY5MjY1fQ.GlXPOaQC_D8nJ79l3Y0UKFyNpPyWyMnSkHSJhWbmWQ8', 'EnrollmentAgreement1.pdf', 'failed', '2025-12-08', '2025-12-08T22:34:26.168512+00:00', '2025-12-08T22:34:34.963861+00:00', NULL, '33d5c056-1f17-46e3-bfa8-810400083e24') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('8eb03b5f-4b15-4499-bc3b-91321744c52f', 'b0c73890-3fdf-49f2-b4af-29530c8ad59a', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/b0c73890-3fdf-49f2-b4af-29530c8ad59a/1765359348941_Emilio%20project.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzL2IwYzczODkwLTNmZGYtNDlmMi1iNGFmLTI5NTMwYzhhZDU5YS8xNzY1MzU5MzQ4OTQxX0VtaWxpbyBwcm9qZWN0LnBkZiIsImlhdCI6MTc2NTM1OTM1MSwiZXhwIjoxNzk2ODk1MzUxfQ.ZqMGB5_mR4CCKtiYpHp2i9W3UUw_6ZC9Zx7IPIZ5ThU', 'Emilio project.pdf', 'completed', '2025-12-10', '2025-12-10T09:35:51.7008+00:00', '2025-12-10T09:35:57.969829+00:00', NULL, '33d5c056-1f17-46e3-bfa8-810400083e24') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('e76e466f-4bce-4f6c-ab02-3ab4d7edc65a', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1765746573416_VALORACIONR2091BBS.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzY1NzQ2NTczNDE2X1ZBTE9SQUNJT05SMjA5MUJCUy5wZGYiLCJpYXQiOjE3NjU3NDY1NzAsImV4cCI6MTc5NzI4MjU3MH0.RVLhDphjBFe86ns1QfA7_UH6le6wLTQvbAYIEYfMw1I', 'VALORACIONR2091BBS.pdf', 'completed', '2025-12-14', '2025-12-14T21:09:30.52637+00:00', '2025-12-14T21:09:34.702619+00:00', '2024-12-23', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('dc6e0d94-ffca-4094-93ab-8b11148ddaca', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1767032717113_VALORACION%207824GSL%20(1).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzY3MDMyNzE3MTEzX1ZBTE9SQUNJT04gNzgyNEdTTCAoMSkucGRmIiwiaWF0IjoxNzY3MDMyNzIwLCJleHAiOjE3OTg1Njg3MjB9.opd0sXB1FYoiFQWqdlupeUbShwpy9aQDBiKGwuSpWPs', 'VALORACION 7824GSL (1).pdf', 'processing', '2025-12-29', '2025-12-29T18:25:21.194082+00:00', '2025-12-29T18:25:21.194082+00:00', NULL, 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('8a08fca0-8775-41cb-9ba8-68e76b326a34', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1767033186549_VALORACION%207824GSL%20(1).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzY3MDMzMTg2NTQ5X1ZBTE9SQUNJT04gNzgyNEdTTCAoMSkucGRmIiwiaWF0IjoxNzY3MDMzMTkwLCJleHAiOjE3OTg1NjkxOTB9.6dXEQ_48XeLbOhflvjsxSwutLXmMXEprq_79S7vfbyw', 'VALORACION 7824GSL (1).pdf', 'processing', '2025-12-29', '2025-12-29T18:33:11.039035+00:00', '2025-12-29T18:33:11.039035+00:00', NULL, 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('49b62d8c-b979-481d-913b-0a12ff98f802', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1767085105372_VALORACION%206536DPY.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzY3MDg1MTA1MzcyX1ZBTE9SQUNJT04gNjUzNkRQWS5wZGYiLCJpYXQiOjE3NjcwODUxMDMsImV4cCI6MTc5ODYyMTEwM30.SrrfyHJDDykFSafNegyaxah6-IgefzbKjs7DIJQ28NA', 'VALORACION 6536DPY.pdf', 'completed', '2025-12-30', '2025-12-30T08:58:23.333273+00:00', '2025-12-30T08:58:27.884162+00:00', '2025-12-22', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('5c4530bd-67b6-48c9-b641-1e458fbfcebb', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1767121201897_VALORACION%207824GSL%20(1).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzY3MTIxMjAxODk3X1ZBTE9SQUNJT04gNzgyNEdTTCAoMSkucGRmIiwiaWF0IjoxNzY3MTIxMjA3LCJleHAiOjE3OTg2NTcyMDd9.VdotFTdwxrlBmI3RcCvE0qWj5BNl3vj3f4atcu72q8U', 'VALORACION 7824GSL (1).pdf', 'processing', '2025-12-30', '2025-12-30T19:00:07.561745+00:00', '2025-12-30T19:00:07.561745+00:00', NULL, 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('30c374c1-0aa5-401e-911e-abee43acaeda', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1767630198436_VALORACION%207824GSL%20(1).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzY3NjMwMTk4NDM2X1ZBTE9SQUNJT04gNzgyNEdTTCAoMSkucGRmIiwiaWF0IjoxNzY3NjMwMjAyLCJleHAiOjE3OTkxNjYyMDJ9.AsqHkTDwjMsDLJLcw9xM8Wc8AZKsKpazVM7wyMO7X_A', 'VALORACION 7824GSL (1).pdf', 'processing', '2026-01-05', '2026-01-05T16:23:22.805502+00:00', '2026-01-05T16:23:22.805502+00:00', NULL, 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('c14fa821-5b51-44e7-b101-7a8c833e2701', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1769783276104_5283KGB%20VALORACION.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzY5NzgzMjc2MTA0XzUyODNLR0IgVkFMT1JBQ0lPTi5wZGYiLCJpYXQiOjE3Njk3ODMyNzQsImV4cCI6MTgwMTMxOTI3NH0.mdv-I9f8shj_9XIqiTNJNbmxESvbzn5b15a0qIIdzPU', '5283KGB VALORACION.pdf', 'completed', '2026-01-30', '2026-01-30T14:27:54.409633+00:00', '2026-01-30T14:28:03.631345+00:00', '2025-07-22', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('995507b9-539f-4ddb-b72c-0e473457a136', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1770314260158_2537LPX%20VALORACION.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzcwMzE0MjYwMTU4XzI1MzdMUFggVkFMT1JBQ0lPTi5wZGYiLCJpYXQiOjE3NzAzMTQyNTksImV4cCI6MTgwMTg1MDI1OX0.5co0d8zedkxfQgtV_jVDGdYhQeCov5k8w1qvV8NhVi4', '2537LPX VALORACION.pdf', 'completed', '2026-02-05', '2026-02-05T17:57:40.287091+00:00', '2026-02-05T17:57:56.102943+00:00', '2026-01-21', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('b5ef4ae3-5983-4ace-8c9a-6a02cb573619', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1770645893976_25-11-26%20MULTIVALORACION%20R2483BDL.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzcwNjQ1ODkzOTc2XzI1LTExLTI2IE1VTFRJVkFMT1JBQ0lPTiBSMjQ4M0JETC5wZGYiLCJpYXQiOjE3NzA2NDU4OTUsImV4cCI6MTgwMjE4MTg5NX0.5MS_sC_Tdkl_9qPAClBHPKiQCZhngLQkTl5o3S0DzfA', '25-11-26 MULTIVALORACION R2483BDL.pdf', 'completed', '2026-02-09', '2026-02-09T14:04:56.202774+00:00', '2026-02-09T14:05:07.111437+00:00', '2025-11-26', 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('8abc0c14-585e-4dcc-a205-5aab0918c992', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/2ccb2fcc-314f-4efa-8d6a-fb44862a48e1/1771241778342_25-11-26%20MULTIVALORACION%20R2483BDL.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzJjY2IyZmNjLTMxNGYtNGVmYS04ZDZhLWZiNDQ4NjJhNDhlMS8xNzcxMjQxNzc4MzQyXzI1LTExLTI2IE1VTFRJVkFMT1JBQ0lPTiBSMjQ4M0JETC5wZGYiLCJpYXQiOjE3NzEyNDE3NzksImV4cCI6MTgwMjc3Nzc3OX0.EFD4vg5RZQtMLYkf56_Qed4w6YgDghE117TqQtF6JYY', '25-11-26 MULTIVALORACION R2483BDL.pdf', 'completed', '2026-02-16', '2026-02-16T11:36:20.297337+00:00', '2026-02-16T11:36:26.919534+00:00', '2025-11-26', 'c378f51e-ec17-42b6-be0d-142865116848') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('b274ff4e-6df6-457d-96be-3f2d69a52d37', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1783596181168_report_1772552491808.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzgzNTk2MTgxMTY4X3JlcG9ydF8xNzcyNTUyNDkxODA4LnBkZiIsInNjb3BlIjoiZG93bmxvYWQiLCJpYXQiOjE3ODM1OTYxNzgsImV4cCI6MTgxNTEzMjE3OH0.vpK_adu41wdoWkNgRRMCHBlK3hkCudtEaM--ZgOF1Vk', 'report_1772552491808.pdf', 'failed', '2026-07-09', '2026-07-09T11:22:58.627463+00:00', '2026-07-09T11:23:06.952434+00:00', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('a4acd0d2-7a10-4d0a-8d35-e302df8f1a61', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1783596286037_report_1772552491808.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzgzNTk2Mjg2MDM3X3JlcG9ydF8xNzcyNTUyNDkxODA4LnBkZiIsInNjb3BlIjoiZG93bmxvYWQiLCJpYXQiOjE3ODM1OTYyODMsImV4cCI6MTgxNTEzMjI4M30.fqiaJF2zC-rtdRomqHumS3w0wO9jS1culagASva3bgo', 'report_1772552491808.pdf', 'failed', '2026-07-09', '2026-07-09T11:24:43.458286+00:00', '2026-07-09T11:24:47.481489+00:00', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('d0a8597f-fbbe-4168-adf8-08de7b2445fe', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1783683338033_2806LHJ%20TALLER.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzgzNjgzMzM4MDMzXzI4MDZMSEogVEFMTEVSLnBkZiIsInNjb3BlIjoiZG93bmxvYWQiLCJpYXQiOjE3ODM2ODMzNDYsImV4cCI6MTgxNTIxOTM0Nn0.5PIbQqPqHB94iDb9-qOv9wE77OtuAeZbeT4UoZVpSE4', '2806LHJ TALLER.pdf', 'failed', '2026-07-10', '2026-07-10T11:35:46.772882+00:00', '2026-07-10T11:35:50.852302+00:00', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('353900ac-dde9-4c4a-8482-67f879a7eae6', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1783683483015_2806LHJ%20TALLER.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzgzNjgzNDgzMDE1XzI4MDZMSEogVEFMTEVSLnBkZiIsInNjb3BlIjoiZG93bmxvYWQiLCJpYXQiOjE3ODM2ODM0OTEsImV4cCI6MTgxNTIxOTQ5MX0.mhdW_eQxicH6uqZ59Vk6oWETWjy0AgYSRGLBdpo3saM', '2806LHJ TALLER.pdf', 'failed', '2026-07-10', '2026-07-10T11:38:11.5072+00:00', '2026-07-10T11:38:15.949961+00:00', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."analysis" ("id", "user_id", "pdf_url", "pdf_filename", "status", "analysis_date", "created_at", "updated_at", "valuation_date", "workshop_id") VALUES ('6389952e-cdf0-43bd-9a6e-2dff3b40e6c3', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 'https://piynzvpnurnvbrmkyneo.supabase.co/storage/v1/object/sign/analysis-pdfs/30e2ccb0-f8ad-45a7-b6dd-ed810c93f212/1783683682936_2806LHJ%20TALLER.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV83Mzg4ODZmMi0wNzdlLTQ4MTEtYjRiMC0yMGU4ZjhhY2ExOGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhbmFseXNpcy1wZGZzLzMwZTJjY2IwLWY4YWQtNDVhNy1iNmRkLWVkODEwYzkzZjIxMi8xNzgzNjgzNjgyOTM2XzI4MDZMSEogVEFMTEVSLnBkZiIsInNjb3BlIjoiZG93bmxvYWQiLCJpYXQiOjE3ODM2ODM2OTEsImV4cCI6MTgxNTIxOTY5MX0.Z5YkctBVoznVGAqtewiZvz0xcXIMLuh0YOIyK4RMPL0', '2806LHJ TALLER.pdf', 'failed', '2026-07-10', '2026-07-10T11:41:31.866831+00:00', '2026-07-10T11:41:35.963625+00:00', NULL, NULL) ON CONFLICT DO NOTHING;

-- Data for vehicle_data
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('d577f23e-f6ee-4df3-84a4-91086017d5e1', 'b2c426c0-90aa-4bc4-8949-f1959cd64d11', '6453MLT', 'WF02XXERK2PJ11480', 'FORD', 'PUMA', '103889801331', 'AUDATEX', 51.9, '2025-10-24T20:16:25.863604+00:00', '2025-10-24T20:16:25.863604+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('9ab883fc-3de2-4077-9eb6-1caa792f70bb', 'c012c32e-3cf6-4939-9f98-ef9dcb706e2b', '6453MLT', 'WF02XXERK2PJ11480', 'FORD', 'PUMA', '103889801331', 'AUDATEX', 51.9, '2025-10-24T20:32:43.556628+00:00', '2025-10-24T20:32:43.556628+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('3d0a0195-d7a4-41da-b5f8-8ec9ebbffc1d', '025d67fb-1e47-430d-b4d2-0026906f066e', '6453MLT', 'WF02XXERK2PJ11480', 'FORD', 'PUMA', '103889801331', 'AUDATEX', 51.9, '2025-10-25T04:49:56.171138+00:00', '2025-10-25T04:49:56.171138+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('7fa80cb4-7b59-4afe-9699-e923b40574e7', '151c5507-c5bf-4fc7-ade9-7b93b83861dc', '6453MLT', 'WF02XXERK2PJ11480', 'FORD', 'PUMA', '103889801331', 'AUDATEX', 51.9, '2025-10-25T04:54:44.486335+00:00', '2025-10-25T04:54:44.486335+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('94fdcf22-60be-4f42-b857-4fc047e8a8f4', 'd5daf860-cd18-4371-9f47-9a765b9fc160', '6453MLT', 'WF02XXERK2PJ11480', 'FORD', 'PUMA', '103889801331', 'AUDATEX', 51.9, '2025-10-25T05:03:23.183274+00:00', '2025-10-25T05:03:23.183274+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('510453a5-9057-4518-9f98-22788230e71b', '8eb539f0-73b2-472c-87d4-e7b5d2f5109a', '6453MLT', 'WF02XXERK2PJ11480', 'FORD', 'PUMA', '103889801331', 'AUDATEX', 51.9, '2025-10-25T05:08:31.063549+00:00', '2025-10-25T05:08:31.063549+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('03610342-c135-4cf7-a7e9-95380ca026f3', 'f7f170b1-b589-49cc-9a74-1378c2a84a47', '6453MLT', 'WF02XXERK2PJ11480', 'FORD', 'PUMA', '103889801331', 'AUDATEX', 51.9, '2025-10-25T05:09:24.044873+00:00', '2025-10-25T05:10:25.779015+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('162393fd-45f2-4343-8f60-9f81bc763e2e', '5ed19d5c-7d5d-4a49-a05f-f13477b20d9e', '6453MLT', 'WF02XXERK2PJ11480', 'FORD', 'PUMA', '103889801331', 'AUDATEX', 51.9, '2025-10-25T05:12:29.802071+00:00', '2025-10-25T05:14:18.919465+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('8e54408e-91e7-44c7-ae7a-e22751a2c289', 'bac69b7f-0741-4c3c-b15f-f1d5fb26c475', '6453MLT', 'WF02XXERK2PJ11480', 'FORD', 'PUMA', '103889801331', 'AUDATEX', 51.9, '2025-10-25T11:45:39.075046+00:00', '2025-10-25T11:45:39.075046+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('0a2a604b-a8ad-4b20-8740-c762ce18de1c', '3dadd1da-b2da-4cac-b21d-28b10658b2bc', '6453MLT', 'WF02XXERK2PJ11480', 'FORD', 'PUMA', '103889801331', 'AUDATEX', 51.9, '2025-10-25T11:52:39.518122+00:00', '2025-10-25T11:52:39.518122+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('31619e02-98be-432a-ac5a-8894c306c3b4', '3af195dd-efcb-4f7d-aa88-8eadda5ee2ea', '6453MLT', 'WF02XXERK2PJ11480', 'FORD', 'PUMA', '103889801331', 'AUDATEX', 51.9, '2025-10-25T12:14:46.722508+00:00', '2025-10-25T12:14:46.722508+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('2bd8d9da-4720-4341-b78d-ac0dedffcfe2', '8bd49f48-af6c-4257-a055-697abf4de5e8', '6453MLT', 'WF02XXERK2PJ11480', 'FORD', 'PUMA', '103889801331', 'AUDATEX', 51.9, '2025-10-25T12:18:41.5903+00:00', '2025-10-25T12:18:41.5903+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('1fb540b3-7f2e-4d67-bda3-131cda9c8947', '9eecc801-d9a1-4aaa-8f6d-dd0b0f3cffa1', '6453MLT', 'WF02XXERK2PJ11480', 'FORD', 'PUMA', '103889801331', 'AUDATEX', 51.9, '2025-10-25T12:24:21.093675+00:00', '2025-10-25T12:25:35.200414+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('0d0cb742-a1dd-4294-9459-6c9f34486635', '1eaab974-3d0c-47e8-b256-092546805966', '6453MLT', 'WF02XXERK2PJ11480', 'FORD', 'PUMA', '103889801331', 'AUDATEX', 51.9, '2025-10-25T12:28:33.045562+00:00', '2025-10-25T12:30:16.840709+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('87fb661a-3449-4efa-8b65-4f6f1e703597', '761d4e93-6d8f-4747-aaa2-73cf16dafb14', '6453MLT', 'WF02XXERK2PJ11480', 'FORD', 'PUMA', '103889801331', 'AUDATEX', 51.9, '2025-10-25T12:32:53.691882+00:00', '2025-10-25T12:32:53.691882+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('d066e65c-d12b-4cbb-ac11-8db12d45e46f', 'c9e852a0-cf25-4af0-a367-b04128e1754e', '6078GGM', 'JTMBA31V805086579', 'Toyota', 'RAV4', '43999424', 'SilverDAT', 30, '2025-10-25T12:35:54.414925+00:00', '2025-10-25T12:35:54.414925+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('b6653a5e-5ea6-4c50-beb0-6757bb75da26', '08adf655-1ad7-44df-a9c6-05ff83b61f82', '6078GGM', 'JTMBA31V805086579', 'Toyota', 'RAV4', '43999424', 'SilverDAT', 30, '2025-10-25T12:45:00.187725+00:00', '2025-10-25T12:45:00.187725+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('93dafed8-57a7-4f92-a709-dba2d8670032', '8223a51f-6018-41a7-a747-88eaa833b136', '6078GGM', 'JTMBA31V805086579', 'Toyota', 'RAV4', '43999424', 'SilverDAT', 30, '2025-10-25T12:55:06.498432+00:00', '2025-10-25T12:55:06.498432+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('a5839a70-fef8-4799-a707-fb95a7af278e', '5eaf394f-8b36-46f6-9f87-deb04ef07ffc', '6078GGM', 'JTMBA31V805086579', 'Toyota', 'RAV4', '43999424', 'SilverDAT', 30, '2025-10-27T01:00:32.062279+00:00', '2025-10-27T01:00:32.062279+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('f31231e4-4647-4381-8abe-04ca8e698e3c', '65e8c60b-7b0b-437e-bde4-528ea472038d', '6453MLT', 'WF02XXERK2PJ11480', 'FORD', 'PUMA', '103889801331', 'AUDATEX', 51.9, '2025-10-27T09:47:07.553486+00:00', '2025-10-27T09:47:07.553486+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('6cd21cdd-3679-4095-8b98-bf65ee9eca48', 'd1d0fc4c-e178-47ab-8fbd-0df854afae31', '6453MLT', 'WF02XXERK2PJ11480', 'FORD', 'PUMA', '103889801331', 'AUDATEX', 51.9, '2025-10-27T11:15:10.102655+00:00', '2025-10-27T11:15:10.102655+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('a4fe994b-fe5a-4908-813c-71b45d1c521c', 'a49c9617-8c50-4bdc-b758-757cef41da85', '6453MLT', 'WF02XXERK2PJ11480', 'FORD', 'PUMA', '103889801331', 'AUDATEX', 51.9, '2025-10-27T11:21:24.467433+00:00', '2025-10-27T11:21:24.467433+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('81856b52-714b-416d-8a91-bdb39a4471ea', 'a5d85a2d-364c-4500-9192-6cbeac8c3e3e', '2996HDN', 'WVWZZZ6RZBY312881', 'Volkswagen', 'Polo V (6R1)(06.2009->) Advance', '50800003', 'SilverDAT', 50, '2025-10-28T08:19:07.45253+00:00', '2025-10-28T08:19:07.45253+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('041ca205-423b-46e5-a057-2f44d116bea0', '5f2bdcd7-7262-4bf4-91b8-e1b02dd14e70', '2996HDN', 'WVWZZZ6RZBY312881', 'Volkswagen', 'Polo V (6R1)(06.2009->) Advance', '50800003', 'SilverDAT', 50, '2025-10-28T08:28:37.273182+00:00', '2025-10-28T08:28:37.273182+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('3d99d708-38da-4f25-b10c-996fa28388d8', '81caf459-9bfa-4800-a09b-20b63ad3eeb2', '6078GGM', 'JTMBA31V805086579', 'Toyota', 'RAV4', '43999424', 'SilverDAT', 30, '2025-10-30T13:36:11.901495+00:00', '2025-10-30T13:36:11.901495+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('b3dae4b2-55bf-4dba-997f-ad9ec177ab73', '0d6ef303-ec74-4446-b969-c56787e48980', '6078GGM', 'JTMBA31V805086579', 'Toyota', 'RAV4', '43999424', 'SilverDAT', 30, '2025-10-30T15:36:38.449538+00:00', '2025-10-30T15:36:38.449538+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('63bed4de-f0ed-4d7a-b009-e57b58e1a407', '4c8afcd0-106d-4b98-ae74-1c9510559375', '6078GGM', 'JTMBA31V805086579', 'Toyota', 'RAV4', '43999424', 'SilverDAT', 30, '2025-10-30T17:13:51.846458+00:00', '2025-10-30T17:13:51.846458+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('08395dd9-3472-45c7-8d3b-67753c315a4c', 'bc001503-bb09-489a-8325-597b975ae818', '6078GGM', 'JTMBA31V805086579', 'Toyota', 'RAV4', '43999424', 'SilverDAT', 30, '2025-10-30T17:15:31.631164+00:00', '2025-10-30T17:15:31.631164+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('594fa00f-59ea-4882-bf7c-f5b8051a9754', '10dc352c-a7db-412b-bb75-3a3879b7839b', '3177LNN', 'VR3UPHNEKM5804089', 'Peugeot', '208', '35462538', 'SilverDAT', 60.2, '2025-10-30T19:32:43.743533+00:00', '2025-10-30T19:32:43.743533+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('f6bc12a5-4bbc-4843-acc5-dd1468b9a925', '411c4f4d-5d65-4742-bac6-e39209d2b057', '3177LNN', 'VR3UPHNEKM5804089', 'Peugeot', '208', '35462538', 'AUDATEX', 24.97, '2025-10-30T19:35:01.451207+00:00', '2025-10-30T19:37:07.901662+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('12457883-48b4-4576-ba9b-ec97c4491249', '00732566-2c92-4439-b0d1-a5dc224e9985', '2384LCH', 'WDF9634031C015121', 'Mercedes-Benz', 'Actros 5', '42141442', 'SilverDAT', 60, '2025-11-03T09:27:00.238636+00:00', '2025-11-03T09:32:03.723796+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('b964059c-eecf-4c71-88a9-ff3fe7fa2ce5', '6df31cac-1ff0-4dd1-ab6c-7fd437a70528', '7782JMY', 'VF38CXFXA81470040', 'Peugeot', '406 Coupé', '601.935/2024 - AP', 'Mutua Madrileña', 30.43, '2025-11-12T08:45:31.409438+00:00', '2025-11-12T08:50:52.909928+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('64fe7aad-37e9-4f6b-bb21-f2147ef27e2a', 'c356fb28-ff3f-43ca-890c-f22324567222', '2384LCH', 'WDF9634031C015121', 'Mercedes-Benz', 'Actros 5', '42141442', 'SilverDAT', 36, '2025-11-03T09:57:17.770282+00:00', '2025-11-03T09:59:50.270602+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('c531bb89-4a51-4b42-9162-1bd2357c3a76', '5fb11745-72b3-47a7-9e76-01a1ec583ddb', '8062JWG', 'JTMWRREV10D027712', 'Toyota', 'RAV4 Hybrid Executive', '50216973', 'SilverDAT', 69, '2025-11-05T10:52:37.34754+00:00', '2025-11-05T10:52:37.34754+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('87c36fd5-f92c-42e2-8dcb-c24226880323', 'ffc87a99-b310-48c1-8a15-bd0bac2d3b93', '8062JWG', 'JTMWRREV10D027712', 'Toyota', 'RAV4 Hybrid Executive', '50216973', 'SilverDAT', 32.5, '2025-11-05T10:52:52.899412+00:00', '2025-11-05T10:52:52.899412+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('1e23a803-6a64-4785-8631-a2fc1e440bf7', '2bc90494-ace8-405b-8090-2a2aca5b0d99', '8062JWG', 'JTMWRREV10D027712', 'Toyota', 'RAV4 Hybrid Executive', '50216973', 'Occident', 32.5, '2025-11-05T10:54:06.567619+00:00', '2025-11-05T10:56:41.963999+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('0cfa1263-d2bb-4580-89ae-0a42ee2ae392', '32ecf060-c119-406b-8ba9-b529c9635484', '9763JYM', 'JTDFR320X00048796', 'Toyota', 'MR 2 Roadster (W30)(2000->) 1.8', '44916009', 'SilverDAT', 40, '2025-11-07T09:46:25.39159+00:00', '2025-11-07T09:48:25.493816+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('73c22d8a-c029-4223-94d8-54a12b489537', 'b343a3b4-1a75-4e5a-b336-f25a1fddfa1e', '9763JYM', 'JTDFR320X00048796', 'Toyota', 'MR 2 Roadster (W30)(2000->) 1.8', '44916009', 'SilverDAT', 40, '2025-11-07T09:57:40.353115+00:00', '2025-11-07T09:57:40.353115+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('b3265a47-d3d6-4a3c-a9a8-15e58fc90041', '746c2bc5-0672-4178-9984-1f6c9a4435d4', '9763JYM', 'JTDFR320X00048796', 'Toyota', 'MR 2 Roadster (W30)(2000->) 1.8', '44916009', 'SilverDAT', 40, '2025-11-07T10:04:21.731832+00:00', '2025-11-07T10:04:21.731832+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('09eb9364-84dd-4aab-b7b0-9bd5cde1ed9a', 'c15703ca-50d0-46eb-bcf9-54692df84492', '7782JMY', 'VF38CXFXA81470040', 'Peugeot', '406 Coupé', '45862448', 'SilverDAT', 82, '2025-11-12T08:44:24.832375+00:00', '2025-11-12T08:44:24.832375+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('aea8d46a-651c-4140-8eb5-52cfbf7f4ad3', '810583fe-81b0-4146-ade7-7b6356dddded', '7782JMY', 'VF38CXFXA81470040', 'Peugeot', '406 Coupé', '601.935/2024 - AP', 'Mutua Madrileña', 30.43, '2025-11-12T09:06:42.033039+00:00', '2025-11-12T09:10:30.525884+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('1f699cae-8e77-4078-aa3b-2c4c5855c398', '7725d35f-3e18-4e28-8e27-463a878f33cf', '7824GSL', 'KNABJ514AAT875717', 'Kia', 'Picanto', '28222454', 'SilverDAT', 59.48, '2025-11-14T08:37:57.632513+00:00', '2025-11-14T08:37:57.632513+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('907e645a-64d0-467b-a7b3-4c8573d91b88', '650e7146-94b7-490c-b06b-4ca6e4c047e0', '7824GSL', 'KNABJ514AAT875717', 'Kia', 'Picanto', '28222454', 'SilverDAT', 59.48, '2025-11-14T08:46:33.165097+00:00', '2025-11-14T08:46:33.165097+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('6d9c28cb-1e03-4c6c-83ea-26bfb142f670', '671a884b-d938-40c4-9b01-13f0bd7453a8', '7824GSL', 'KNABJ514AAT875717', 'Kia', 'Picanto', '28222454', 'SilverDAT', 59.48, '2025-11-14T08:48:14.024728+00:00', '2025-11-14T08:48:14.024728+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('89d25ef3-b4bb-4d64-8b02-431f4dda9457', '8eb03b5f-4b15-4499-bc3b-91321744c52f', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-10T09:35:57.07713+00:00', '2025-12-10T09:35:57.07713+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('08f55618-b4a1-4204-a7b6-607007e8b96a', 'e76e466f-4bce-4f6c-ab02-3ab4d7edc65a', 'R2091BBS', 'VSRSR3L04ML064223', 'Otros', 'Remolque/Semirremo', '2024/55/54230/01', NULL, 46, '2025-12-14T21:09:34.33732+00:00', '2025-12-14T21:09:34.33732+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('7e2c01f2-ec08-43bf-befe-db2a0a52c63d', '49b62d8c-b979-481d-913b-0a12ff98f802', '6536DPY', 'VSSZZZ1MZ5R087524', 'SEAT', 'CUPRA LEON (1M) (99-06)', 'CLM2449314', 'GT MOTIVE', 35, '2025-12-30T08:58:27.606942+00:00', '2025-12-30T08:58:27.606942+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('dff07192-8f59-4995-b8f2-7f9aab6d042b', 'c14fa821-5b51-44e7-b101-7a8c833e2701', '5283KGB', 'W0LDD6E71HC792361', 'OPEL', 'KARL (D) 5P (15-19)', 'CLM2136063', 'GT MOTIVE', 37.89, '2026-01-30T14:28:03.338266+00:00', '2026-01-30T14:28:03.338266+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('e84efe16-3aeb-4eb4-a5fd-b2c4377779fc', '995507b9-539f-4ddb-b72c-0e473457a136', '2537LPX', 'JTMW23FVX0D085253', 'Toyota', 'RAV4 Hybrid 4x2 Advance Plus', 'EXP260066', 'SilverDAT', 35, '2026-02-05T17:57:55.711449+00:00', '2026-02-05T17:57:55.711449+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('fbcdfab5-2b44-4694-accc-ded6d2425766', 'b5ef4ae3-5983-4ace-8c9a-6a02cb573619', 'R2483BDL', 'WSM00000007036686', 'Otros', 'Furgón/Chasis cabi', '25A097618', 'AUDATEX', 80, '2026-02-09T14:05:06.160131+00:00', '2026-02-09T14:05:06.160131+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('63697ce6-2cf9-4e1a-bc66-b7e12c29e662', '8abc0c14-585e-4dcc-a205-5aab0918c992', 'R2483BDL', 'WSM00000007036686', 'Otros', 'Furgón/Chasis cabi', '25A097618', 'AUDATEX', 80, '2026-02-16T11:36:26.194508+00:00', '2026-02-16T11:36:26.194508+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('713c35d6-889f-4e62-8df1-c81d556cced0', 'b274ff4e-6df6-457d-96be-3f2d69a52d37', '1234ABC', 'WVWZZZ1JZ3W123456', 'VOLKSWAGEN', 'GOLF', 'REF-2024-001', 'AUDATEX', 45, '2026-07-09T11:23:06.093037+00:00', '2026-07-09T11:23:06.093037+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('81b19053-575b-4a74-8c8e-be6b0f44d0fe', 'a4acd0d2-7a10-4d0a-8d35-e302df8f1a61', '1234ABC', 'WVWZZZ1JZ3W123456', 'VOLKSWAGEN', 'GOLF', 'REF-2024-001', 'AUDATEX', 45, '2026-07-09T11:24:47.042618+00:00', '2026-07-09T11:24:47.042618+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('1413f8e6-2134-4eda-bbd6-eb27080293f0', 'd0a8597f-fbbe-4168-adf8-08de7b2445fe', '1234ABC', 'WVWZZZ1JZ3W123456', 'VOLKSWAGEN', 'GOLF', 'REF-2024-001', 'AUDATEX', 45, '2026-07-10T11:35:50.599964+00:00', '2026-07-10T11:35:50.599964+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('da194159-3ec3-45a9-a00a-336f4756cd14', '353900ac-dde9-4c4a-8482-67f879a7eae6', '1234ABC', 'WVWZZZ1JZ3W123456', 'VOLKSWAGEN', 'GOLF', 'REF-2024-001', 'AUDATEX', 45, '2026-07-10T11:38:15.725227+00:00', '2026-07-10T11:38:15.725227+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."vehicle_data" ("id", "analysis_id", "license_plate", "vin", "manufacturer", "model", "internal_reference", "system", "hourly_price", "created_at", "updated_at") VALUES ('1006f118-9242-4526-9883-ae3653f93d07', '6389952e-cdf0-43bd-9a6e-2dff3b40e6c3', '1234ABC', 'WVWZZZ1JZ3W123456', 'VOLKSWAGEN', 'GOLF', 'REF-2024-001', 'AUDATEX', 45, '2026-07-10T11:41:35.727547+00:00', '2026-07-10T11:41:35.727547+00:00') ON CONFLICT DO NOTHING;

-- Data for insurance_amounts
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('928b09ed-5b21-4018-9d81-c6b46d15f91e', 'b2c426c0-90aa-4bc4-8949-f1959cd64d11', 1782.92, 128, 679.89, 52.5, 272.48, 213.2, 2948.49, 619.18, 3567.67, '2025-10-24T20:16:26.246863+00:00', '2025-10-24T20:16:26.246863+00:00', 21, 12.8, 5.25, NULL, 51.9, 51.9, 12) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('f9da48f0-a5e9-4293-9cc5-f0c9d49570cb', 'c012c32e-3cf6-4939-9f98-ef9dcb706e2b', 1782.92, 128, 679.89, 52.5, 272.48, 213.2, 2948.49, 619.18, 3567.67, '2025-10-24T20:32:43.969057+00:00', '2025-10-24T20:32:43.969057+00:00', 21, 12.8, 5.25, NULL, 51.9, 51.9, 12) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('0ef0d8e4-1b3d-44ec-a71c-c124e517d33e', '025d67fb-1e47-430d-b4d2-0026906f066e', 1782.92, 128, 679.89, 52.5, 272.48, 213.2, 2948.49, 619.18, 3567.67, '2025-10-25T04:49:56.408385+00:00', '2025-10-25T04:49:56.408385+00:00', 21, 12.8, 5.25, NULL, 51.9, 51.9, 12) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('e78b5b30-8553-4c82-a5f0-4b1490b867b2', '151c5507-c5bf-4fc7-ade9-7b93b83861dc', 1782.92, 128, 679.89, 52.5, 272.48, 213.2, 2948.49, 619.18, 3567.67, '2025-10-25T04:54:44.630986+00:00', '2025-10-25T04:54:44.630986+00:00', 21, 12.8, 5.25, NULL, 51.9, 51.9, 12) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('3bb57e94-5cd6-48ab-a8a7-d4e6ce4d0b90', 'd5daf860-cd18-4371-9f47-9a765b9fc160', 1782.92, 128, 679.89, 52.5, 272.48, 213.2, 2948.49, 619.18, 3567.67, '2025-10-25T05:03:23.450632+00:00', '2025-10-25T05:03:23.450632+00:00', 21, 12.8, 5.25, NULL, 51.9, 51.9, 12) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('b92ec977-8796-4929-8cee-f7c524bdba6a', '8eb539f0-73b2-472c-87d4-e7b5d2f5109a', 1782.92, 128, 679.89, 52.5, 272.48, 213.2, 2948.49, 619.18, 3567.67, '2025-10-25T05:08:31.197714+00:00', '2025-10-25T05:08:31.197714+00:00', 21, 12.8, 5.25, NULL, 51.9, 51.9, 12) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('b401def3-792c-41b6-a2a6-5b2b9da0366f', 'f7f170b1-b589-49cc-9a74-1378c2a84a47', 1782.92, 128, 679.89, 52.5, 272.48, 213.2, 2710.23, 0, 2710.23, '2025-10-25T05:09:24.191766+00:00', '2025-10-25T05:10:25.93051+00:00', 0, 12.8, 5.25, NULL, 51.9, 51.9, 12) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('a7dfae23-108e-4475-bf22-8ca1266cd148', '5ed19d5c-7d5d-4a49-a05f-f13477b20d9e', 1782.92, 128, 679.89, 52.5, 272.48, 213.2, 2710.23, 0, 2710.23, '2025-10-25T05:12:29.920943+00:00', '2025-10-25T05:14:19.094976+00:00', 0, 12.8, 5.25, NULL, 51.9, 51.9, 12) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('d021a75c-0e66-4484-b475-15d336673c32', 'bac69b7f-0741-4c3c-b15f-f1d5fb26c475', 1782.92, 128, 679.89, 52.5, 272.48, 213.2, 2948.49, 619.18, 3567.67, '2025-10-25T11:45:39.402058+00:00', '2025-10-25T11:45:39.402058+00:00', 21, 12.8, 5.25, NULL, 51.9, 51.9, 12) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('a8269b7f-7bb4-40a6-b2d5-c02fbe82a8b9', '3dadd1da-b2da-4cac-b21d-28b10658b2bc', 1782.92, 128, 679.89, 52.5, 272.48, 213.2, 2948.49, 619.18, 3567.67, '2025-10-25T11:52:40.26608+00:00', '2025-10-25T11:52:40.26608+00:00', 21, 12.8, 5.25, NULL, 51.9, 51.9, 12) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('7f6a64f8-57ad-4a63-b1b0-4e8ec6a0a144', '3af195dd-efcb-4f7d-aa88-8eadda5ee2ea', 1782.92, 128, 679.89, 52.5, 272.48, 213.2, 2948.49, 619.18, 3567.67, '2025-10-25T12:14:47.1035+00:00', '2025-10-25T12:14:47.1035+00:00', 21, 12.8, 5.25, NULL, 51.9, 51.9, 12) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('fbe85108-e52f-4fa0-ae7b-c00fe1e08aeb', '8bd49f48-af6c-4257-a055-697abf4de5e8', 1782.92, 128, 679.89, 52.5, 272.48, 213.2, 2948.49, 619.18, 3567.67, '2025-10-25T12:18:41.99513+00:00', '2025-10-25T12:18:41.99513+00:00', 21, 12.8, 5.25, NULL, 51.9, 51.9, 12) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('dc569b24-a914-45b2-b0b4-a1fbdc1ecdef', '9eecc801-d9a1-4aaa-8f6d-dd0b0f3cffa1', 1782.92, 128, 679.89, 52.5, 272.48, 213.2, 2710.23, 0, 2710.23, '2025-10-25T12:24:21.359375+00:00', '2025-10-25T12:25:35.576098+00:00', 0, 12.8, 5.25, NULL, 51.9, 51.9, 12) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('aef3a0c8-c0b1-4f34-b016-03b1a5e416d3', '1eaab974-3d0c-47e8-b256-092546805966', 1782.92, 128, 679.89, 52.5, 272.48, 213.2, 2710.23, 0, 2710.23, '2025-10-25T12:28:33.283137+00:00', '2025-10-25T12:30:17.303992+00:00', 0, 12.8, 5.25, NULL, 51.9, 51.9, 12) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('16401967-3139-4a5a-b30c-e0ab608bca4e', '761d4e93-6d8f-4747-aaa2-73cf16dafb14', 1782.92, 128, 679.89, 52.5, 272.48, 213.2, 2710.23, 569.15, 3279.38, '2025-10-25T12:32:54.091299+00:00', '2025-10-25T12:32:54.091299+00:00', 21, 12.8, 5.25, NULL, 51.9, 51.9, 12) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('17c23528-be45-42a3-ae2e-5ad2c1e446bc', 'c9e852a0-cf25-4af0-a367-b04128e1754e', 599.32, 22.87, 714.48, 18.5, 555, 799.5, 2680, 562.8, 3242.8, '2025-10-25T12:35:54.72791+00:00', '2025-10-25T12:35:54.72791+00:00', 21, 22.87, 18.5, NULL, 30, 30, 6) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('c2ff7c85-60da-463b-8e8a-f0a3bf56225b', '08adf655-1ad7-44df-a9c6-05ff83b61f82', 599.32, 22.87, 714.48, 18.5, 555, 799.5, 2680, 562.8, 3242.8, '2025-10-25T12:45:00.59063+00:00', '2025-10-25T12:45:00.59063+00:00', 21, 22.87, 18.5, NULL, 30, 30, 6) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('9835920c-281d-4f8c-b2cf-0ae9027c1384', '8223a51f-6018-41a7-a747-88eaa833b136', 599.32, 22.87, 714.48, 18.5, 555, 799.5, 2680, 562.8, 3242.8, '2025-10-25T12:55:06.908724+00:00', '2025-10-25T12:55:06.908724+00:00', 21, 22.87, 18.5, NULL, 30, 30, 6) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('d3ca8867-0ab5-42c2-be23-4ad3eda6bd8a', '5eaf394f-8b36-46f6-9f87-deb04ef07ffc', 599.32, 22.87, 714.48, 18.5, 555, 799.5, 2680, 562.8, 3242.8, '2025-10-27T01:00:32.53388+00:00', '2025-10-27T01:00:32.53388+00:00', 21, 22.87, 18.5, NULL, 30, 30, 6) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('f23cc4cc-a5ec-42de-a723-909d387f3e20', '65e8c60b-7b0b-437e-bde4-528ea472038d', 1782.92, 128, 679.89, 52.5, 272.48, 213.2, 2710.23, 569.15, 3279.38, '2025-10-27T09:47:07.757325+00:00', '2025-10-27T09:47:07.757325+00:00', 21, 12.8, 5.25, NULL, 51.9, 51.9, 12) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('aff7799f-3bad-4c62-b204-fd7a4b8295bb', 'd1d0fc4c-e178-47ab-8fbd-0df854afae31', 1782.92, 128, 679.89, 52.5, 272.48, 213.2, 2710.23, 569.15, 3279.38, '2025-10-27T11:15:10.341195+00:00', '2025-10-27T11:15:10.341195+00:00', 21, 12.8, 5.25, NULL, 51.9, 51.9, 12) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('0bdc9568-6c13-4a54-9f25-c92b550e8df1', 'a49c9617-8c50-4bdc-b758-757cef41da85', 1782.92, 128, 679.89, 52.5, 272.48, 213.2, 2710.23, 569.15, 3279.38, '2025-10-27T11:21:24.584354+00:00', '2025-10-27T11:21:24.584354+00:00', 21, 12.8, 5.25, NULL, 51.9, 51.9, 12) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('74458bbf-0853-40b0-8be8-4f476b5b4328', 'a5d85a2d-364c-4500-9192-6cbeac8c3e3e', 6325.36, 19.4, 970, 6.7, 335, 229.2, 7859.56, 1650.51, 9510.07, '2025-10-28T08:19:07.63768+00:00', '2025-10-28T08:19:07.63768+00:00', 21, 19.4, 6.7, NULL, 50, 50, 42) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('d7be1ba0-6e1e-4121-83da-e0f9c596b3ae', '5f2bdcd7-7262-4bf4-91b8-e1b02dd14e70', 6325.36, 19.4, 970, 6.7, 335, 229.2, 7859.56, 1650.51, 9510.07, '2025-10-28T08:28:37.393982+00:00', '2025-10-28T08:28:37.393982+00:00', 21, 19.4, 6.7, NULL, 50, 50, 42) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('3fd8f9d4-ea5a-410a-8488-2a2a876ea5f3', '81caf459-9bfa-4800-a09b-20b63ad3eeb2', 599.32, 22.87, 714.48, 18.5, 555, 799.5, 2680, 562.8, 3242.8, '2025-10-30T13:36:12.343108+00:00', '2025-10-30T13:36:12.343108+00:00', 21, 22.87, 18.5, NULL, 30, 30, 6) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('e4f7dadb-b167-4b7c-a2fb-2ea0f68f3c13', '0d6ef303-ec74-4446-b969-c56787e48980', 599.32, 22.87, 714.48, 18.5, 555, 799.5, 2680, 562.8, 3242.8, '2025-10-30T15:36:38.884236+00:00', '2025-10-30T15:36:38.884236+00:00', 21, 22.87, 18.5, NULL, 30, 30, 6) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('e2fd11f5-2211-44f0-b04a-f1929e7e5b94', '4c8afcd0-106d-4b98-ae74-1c9510559375', 599.32, 22.87, 714.48, 18.5, 555, 799.5, 2680, 562.8, 3242.8, '2025-10-30T17:13:52.339301+00:00', '2025-10-30T17:13:52.339301+00:00', 21, 22.87, 18.5, NULL, 30, 30, 6) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('5a07ff44-1bbd-48e3-8586-c53e37becbfc', 'bc001503-bb09-489a-8325-597b975ae818', 599.32, 22.87, 714.48, 18.5, 555, 799.5, 2680, 562.8, 3242.8, '2025-10-30T17:15:32.004637+00:00', '2025-10-30T17:15:32.004637+00:00', 21, 22.87, 18.5, NULL, 30, 30, 6) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('5db8a5d9-73c1-4de3-92e5-e21f520115b6', '10dc352c-a7db-412b-bb75-3a3879b7839b', 125.91, 11.7, 704.34, 15.85, 954.17, 310.95, 2095.37, 440.03, 2535.4, '2025-10-30T19:32:44.160772+00:00', '2025-10-30T19:32:44.160772+00:00', 21, 11.7, 15.85, NULL, 60.2, 60.2, 1) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('124973ff-3f72-44b8-9769-5da9467c629c', '411c4f4d-5d65-4742-bac6-e39209d2b057', 122.24, 11.7, 704.34, 15.85, 69.9, 188.6, 840.11, 176.42, 1016.53, '2025-10-30T19:35:01.592112+00:00', '2025-10-30T19:37:08.066502+00:00', 21, 11.7, 9.4, NULL, 60.2, 60.2, 1) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('91c62eb0-1abf-425c-b687-e94ecf92687a', '00732566-2c92-4439-b0d1-a5dc224e9985', 1396.48, 29.4, 1818.7, 7.3, 438, 242.45, 3895.63, 818.08, 4713.71, '2025-11-03T09:27:00.436902+00:00', '2025-11-03T09:32:03.88801+00:00', 21, 29.4, 7.3, NULL, 60, 60, 7) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('51afd82f-ebd3-41f3-b8c3-9f250737725c', 'c356fb28-ff3f-43ca-890c-f22324567222', 1396.48, 29.4, 1057.4, 7.3, 262.8, 242.45, 2959.13, 621.41, 3580.54, '2025-11-03T09:57:17.888237+00:00', '2025-11-03T09:59:50.414598+00:00', 21, 29.4, 7.3, NULL, 60, 60, 7) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('eecc8e86-9f30-475f-a336-8f631a105cf1', 'b343a3b4-1a75-4e5a-b336-f25a1fddfa1e', 4420.37, 14.9, 596, 16.7, 668, 809.25, 6505.32, 1366.12, 7871.44, '2025-11-07T09:57:40.491218+00:00', '2025-11-07T09:57:40.491218+00:00', 21, 14.9, 16.7, NULL, 40, 40, 3) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('72afdd4d-f1cd-4300-aee6-2f772ca02886', '5fb11745-72b3-47a7-9e76-01a1ec583ddb', 331.15, 24.8, 1711.2, 34.1, 2352.9, 1334.45, 5729.7, 1203.24, 6932.94, '2025-11-05T10:52:37.511323+00:00', '2025-11-05T10:52:37.511323+00:00', 21, 24.8, 34.1, NULL, 69, 69, 7) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('87cbf4d0-bb03-4c5d-939c-e5f2996fe1d4', 'ffc87a99-b310-48c1-8a15-bd0bac2d3b93', 331.15, 24.8, 806, 34.1, 1108.27, 1322.75, 3579.87, 751.77, 4331.64, '2025-11-05T10:52:53.02221+00:00', '2025-11-05T10:52:53.02221+00:00', 21, 24.8, 34.1, NULL, 32.5, 32.5, 7) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('edaa03e4-029b-445d-b7a5-734c540b87e4', '2bc90494-ace8-405b-8090-2a2aca5b0d99', 6.01, 24.8, 497.25, 34.1, 503.75, 620.42, 1627.43, 341.76, 1969.19, '2025-11-05T10:54:06.677615+00:00', '2025-11-05T10:56:42.105299+00:00', 21, 15.3, 15.5, NULL, 32.5, 32.5, 1) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('a7e03c8d-8253-49b7-9cfb-4a0e9df1b29c', '32ecf060-c119-406b-8ba9-b529c9635484', 4420.37, 14.9, 596, 16.7, 668, 820.95, 6505.32, 1366.12, 7871.44, '2025-11-07T09:46:25.588077+00:00', '2025-11-07T09:48:25.672369+00:00', 21, 14.9, 16.7, NULL, 40, 40, 3) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('56a989c6-c67c-4ba1-97b3-27bb11076dde', '746c2bc5-0672-4178-9984-1f6c9a4435d4', 4420.37, 14.9, 596, 16.7, 668, 809.25, 6505.32, 1366.12, 7871.44, '2025-11-07T10:04:21.866213+00:00', '2025-11-07T10:04:21.866213+00:00', 21, 14.9, 16.7, NULL, 40, 40, 3) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('8fd1ab95-421e-4835-b47c-cfe701f3ac48', 'c15703ca-50d0-46eb-bcf9-54692df84492', 147.86, 22.1, 1812.2, 21.4, 1754.8, 937.95, 4652.81, 977.09, 5629.9, '2025-11-12T08:44:25.093362+00:00', '2025-11-12T08:44:25.093362+00:00', 21, 22.1, 21.4, NULL, 82, 82, 3) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('1274ea9f-1970-4426-9ddf-f13dc3b5a53c', '6df31cac-1ff0-4dd1-ab6c-7fd437a70528', 1218.35, 22.1, 713.44, 21.4, 473.49, 506.46, 2911.74, 611.46, 3523.2, '2025-11-12T08:45:31.535723+00:00', '2025-11-12T08:50:53.099635+00:00', 21, 23.44, 15, NULL, 82, 82, 6) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('da145216-ed98-4580-b334-b7db788d0de7', '810583fe-81b0-4146-ade7-7b6356dddded', 1218.35, 22.1, 713.44, 21.4, 473.49, 506.46, 2911.74, 611.46, 3523.2, '2025-11-12T09:06:42.139476+00:00', '2025-11-12T09:10:30.679459+00:00', 21, 23.44, 15, NULL, 82, 82, 6) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('534b8c56-3079-49bd-b386-dddae5fb5c7d', '7725d35f-3e18-4e28-8e27-463a878f33cf', 968.21, 36.8, 2188.85, 9.9, 588.86, 219.85, 3965.78, 832.82, 4798.6, '2025-11-14T08:37:57.791213+00:00', '2025-11-14T08:37:57.791213+00:00', 21, 36.8, 9.9, NULL, 59.48, 59.48, 13) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('512c35ef-f392-45cd-9902-5ef6a3198a1e', '650e7146-94b7-490c-b06b-4ca6e4c047e0', 968.21, 36.8, 2188.85, 9.9, 588.86, 219.85, 3965.78, 832.82, 4798.6, '2025-11-14T08:46:33.283997+00:00', '2025-11-14T08:46:33.283997+00:00', 21, 36.8, 9.9, NULL, 59.48, 59.48, 13) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('877b20e5-0769-4f8a-b42c-34f41157eabd', '671a884b-d938-40c4-9b01-13f0bd7453a8', 968.21, 36.8, 2188.85, 9.9, 588.86, 219.85, 3965.78, 832.82, 4798.6, '2025-11-14T08:48:14.145842+00:00', '2025-11-14T08:48:14.145842+00:00', 21, 36.8, 9.9, NULL, 59.48, 59.48, 13) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('72dff466-317d-4a0a-8316-c5014871af7d', '8eb03b5f-4b15-4499-bc3b-91321744c52f', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, '2025-12-10T09:35:57.527521+00:00', '2025-12-10T09:35:57.527521+00:00', 21, NULL, NULL, NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('e31c1443-9165-42e7-ac5f-6dac16612220', 'e76e466f-4bce-4f6c-ab02-3ab4d7edc65a', 4167.28, 495, 2277, NULL, NULL, NULL, 6444.28, 0, 6444.28, '2025-12-14T21:09:34.500181+00:00', '2025-12-14T21:09:34.500181+00:00', 21, 49.5, NULL, NULL, 46, NULL, 8) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('55e6f111-eaf3-4a77-9e7d-034829dc1b60', '49b62d8c-b979-481d-913b-0a12ff98f802', NULL, 2.3, 80.5, 2.25, 78.75, 67.35, 226.6, 47.59, 274.19, '2025-12-30T08:58:27.753733+00:00', '2025-12-30T08:58:27.753733+00:00', 21, 2.3, 2.25, NULL, 35, 35, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('d860cdbf-6a78-4429-85cf-3a34e2dd90d4', 'c14fa821-5b51-44e7-b101-7a8c833e2701', 1104.53, 7.8, 295.55, 3.15, 119.35, 133.51, 1652.94, 347.12, 2000.06, '2026-01-30T14:28:03.483175+00:00', '2026-01-30T14:28:03.483175+00:00', 21, 7.8, 3.15, NULL, 37.89, 37.89, 9) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('21000a7f-0630-41cc-a5e1-037ebd445bbe', '995507b9-539f-4ddb-b72c-0e473457a136', 2345.39, 35.4, 1239, 31.4, 1099, 1413.35, 6096.74, 1280.31, 7377.05, '2026-02-05T17:57:55.950005+00:00', '2026-02-05T17:57:55.950005+00:00', 21, 35.4, 31.4, NULL, 35, 35, 14) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('303e27d5-e55d-4e2b-bfe4-c036b5e05314', 'b5ef4ae3-5983-4ace-8c9a-6a02cb573619', 1075.82, 125, 1565, 125, 1000, 270, 3830.02, 0, 0, '2026-02-09T14:05:06.674542+00:00', '2026-02-09T14:05:06.674542+00:00', 21, 12.5, 12.5, NULL, 80, 80, 20) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('59d0e1cf-9f40-40c1-9566-9d2ccea66fbb', '8abc0c14-585e-4dcc-a205-5aab0918c992', 1075.02, 125, 1565, 125, 1000, 270, 3830.02, 0, 0, '2026-02-16T11:36:26.531618+00:00', '2026-02-16T11:36:26.531618+00:00', 21, 12.5, 12.5, NULL, 80, 80, 20) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('a1a31eb6-a2c9-4519-a83f-ec979b247c63', 'b274ff4e-6df6-457d-96be-3f2d69a52d37', 12505, 85, 3825, 62, 261, 12575, 29166, 6124.86, 35290.86, '2026-07-09T11:23:06.469437+00:00', '2026-07-09T11:23:06.469437+00:00', 21, 85, 62, 'UT', NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('947e58ae-b9cf-4cb6-b16e-5b7973b500d2', 'a4acd0d2-7a10-4d0a-8d35-e302df8f1a61', 12505, 85, 3825, 62, 261, 12575, 29166, 6124.86, 35290.86, '2026-07-09T11:24:47.223939+00:00', '2026-07-09T11:24:47.223939+00:00', 21, 85, 62, 'UT', NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('a4767c1a-7564-4d2f-af13-d01065e4033c', 'd0a8597f-fbbe-4168-adf8-08de7b2445fe', 12505, 85, 3825, 62, 261, 12575, 29166, 6124.86, 35290.86, '2026-07-10T11:35:50.729997+00:00', '2026-07-10T11:35:50.729997+00:00', 21, 85, 62, 'UT', NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('21c971ca-52ba-4e3b-aaa3-586bb6304fed', '353900ac-dde9-4c4a-8482-67f879a7eae6', 12505, 85, 3825, 62, 261, 12575, 29166, 6124.86, 35290.86, '2026-07-10T11:38:15.822113+00:00', '2026-07-10T11:38:15.822113+00:00', 21, 85, 62, 'UT', NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."insurance_amounts" ("id", "analysis_id", "total_spare_parts_eur", "bodywork_labor_ut", "bodywork_labor_eur", "painting_labor_ut", "painting_labor_eur", "paint_material_eur", "net_subtotal", "iva_amount", "total_with_iva", "created_at", "updated_at", "iva_percentage", "bodywork_labor_hours", "painting_labor_hours", "detected_units", "bodywork_hourly_price", "painting_hourly_price", "spare_parts_quantity") VALUES ('13bd04f3-108f-4fdf-9dc0-1b76f304f3f9', '6389952e-cdf0-43bd-9a6e-2dff3b40e6c3', 12505, 85, 3825, 62, 261, 12575, 29166, 6124.86, 35290.86, '2026-07-10T11:41:35.829669+00:00', '2026-07-10T11:41:35.829669+00:00', 21, 85, 62, 'UT', NULL, NULL, NULL) ON CONFLICT DO NOTHING;

-- Data for workshop_costs
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('fb5c4216-e3d1-4079-a257-d323dc5f8372', 'b2c426c0-90aa-4bc4-8949-f1959cd64d11', 500, 20, 45, 10, 45, 250, 100, 20, '', '2025-10-24T20:17:06.144506+00:00', '2025-10-24T20:17:06.144506+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('7694f41b-f517-4fb8-ab74-74634e26e76b', '025d67fb-1e47-430d-b4d2-0026906f066e', 1320, 11.5, 48, 5.5, 48, 165, 0, 0, '', '2025-10-25T04:53:32.851874+00:00', '2025-10-25T04:53:32.851874+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('e1592380-d2a7-4271-961f-8c9898e15dc6', '151c5507-c5bf-4fc7-ade9-7b93b83861dc', 1420, 15.5, 48, 6.5, 48, 200, 0, 0, '', '2025-10-25T04:57:30.132606+00:00', '2025-10-25T04:57:30.132606+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('e699b632-fc90-4d1b-9477-2b788c3011fc', 'd5daf860-cd18-4371-9f47-9a765b9fc160', 1420, 15.5, 48, 6, 48, 145, 0, 0, '', '2025-10-25T05:06:27.151104+00:00', '2025-10-25T05:06:27.151104+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('4d05c6d7-2d4d-4a75-aaf9-a544cbbbb9fe', 'f7f170b1-b589-49cc-9a74-1378c2a84a47', 1420, 15, 48, 6, 48, 135, 0, 0, '', '2025-10-25T05:11:37.075603+00:00', '2025-10-25T05:11:37.075603+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('462b1192-5cce-49f8-8d27-5e03db36ffcf', '5ed19d5c-7d5d-4a49-a05f-f13477b20d9e', 1420, 14, 50, 6, 50, 200, 0, 0, '', '2025-10-25T05:15:10.919388+00:00', '2025-10-25T05:15:10.919388+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('2f9f5bfb-be47-4e0b-a439-98db323d9eea', '9eecc801-d9a1-4aaa-8f6d-dd0b0f3cffa1', 1420, 11, 42, 4.5, 42, 180, 0, 0, '', '2025-10-25T12:27:28.467807+00:00', '2025-10-25T12:27:28.467807+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('2a5bacff-590c-4106-9763-7f8c108740a2', '1eaab974-3d0c-47e8-b256-092546805966', 1420, 14, 56, 5, 56, 180, 0, 0, '', '2025-10-25T12:29:42.813986+00:00', '2025-10-25T12:29:42.813986+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('1e0fd88c-c94c-4922-bda6-678f4216d5a1', '8223a51f-6018-41a7-a747-88eaa833b136', 400, 20, 40, 8, 40, 199.97, 50, 15, '', '2025-10-26T23:42:05.883706+00:00', '2025-10-26T23:42:05.883706+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('2559c0c0-62ad-4496-9644-cccdd83c3e52', '65e8c60b-7b0b-437e-bde4-528ea472038d', 1420, 13, 42, 5, 42, 180, 0, 0, '', '2025-10-27T10:01:41.903447+00:00', '2025-10-27T10:01:41.903447+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('9c3b0961-e115-4551-be20-12ae72feabd1', 'd1d0fc4c-e178-47ab-8fbd-0df854afae31', 1420, 13.1, 42, 5.25, 42, 164, 0.01, 0, '', '2025-10-27T11:17:53.826698+00:00', '2025-10-27T11:17:53.826698+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('f42f7c0e-0c77-428a-b1a0-0973f467b6c6', 'a49c9617-8c50-4bdc-b758-757cef41da85', 1420, 13, 42, 5, 42, 200, 0, 0, '', '2025-10-27T11:21:43.199141+00:00', '2025-10-27T11:21:43.199141+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('4503ae33-0ffb-4d52-8f00-388cfcbfad58', '5f2bdcd7-7262-4bf4-91b8-e1b02dd14e70', 5516.48, 19.4, 39, 6, 39, 128, 0, 0, '', '2025-10-28T08:30:12.636764+00:00', '2025-10-28T08:30:12.636764+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('4bb56c8b-cec6-4ec6-90a7-f5a89f77c819', '411c4f4d-5d65-4742-bac6-e39209d2b057', 100, 10, 37, 13.5, 37, 180, 0, 0, '', '2025-10-30T19:46:37.440438+00:00', '2025-10-30T19:46:37.440438+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('68d8d91d-8e85-4ceb-b115-4f48b0190d90', '10dc352c-a7db-412b-bb75-3a3879b7839b', 100, 10, 37, 13.5, 37, 180, 0, 0, '', '2025-10-30T19:47:37.65633+00:00', '2025-10-30T19:47:37.65633+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('4976f45c-4e47-4c14-ad18-c7352b0c9be3', '00732566-2c92-4439-b0d1-a5dc224e9985', 1173.04, 29, 47, 6, 47, 122, 0, 0, '', '2025-11-03T09:40:09.523584+00:00', '2025-11-03T09:40:09.523584+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('d52d4885-fb26-414d-88ca-433fcbf0c7b3', 'c356fb28-ff3f-43ca-890c-f22324567222', 1173.04, 29, 47, 6, 47, 122, 0, 0, '', '2025-11-03T10:00:26.775333+00:00', '2025-11-03T10:00:26.775333+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('6a00ee4d-e00d-485f-bd98-ba02e235bd29', '2bc90494-ace8-405b-8090-2a2aca5b0d99', 7, 18, 37, 18, 37, 487, 0, 0, '', '2025-11-05T11:01:51.088101+00:00', '2025-11-05T11:01:51.088101+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('a941cbe2-d7fc-4441-9aaf-ab539d6f4df4', 'ffc87a99-b310-48c1-8a15-bd0bac2d3b93', 275, 18, 37, 18, 37, 487, 0, 0, '', '2025-11-05T11:02:28.924427+00:00', '2025-11-05T11:02:28.924427+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('f0cdc2a8-90cd-4b3c-a0e1-ca1c7b4898ae', '5fb11745-72b3-47a7-9e76-01a1ec583ddb', 275, 18, 37, 18, 37, 487, 0, 0, '', '2025-11-05T11:03:00.177382+00:00', '2025-11-05T11:03:00.177382+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('85c1fa4d-a30d-41f8-9c9f-f3eea78ab03f', 'b343a3b4-1a75-4e5a-b336-f25a1fddfa1e', 3508.23, 10.4, 34, 14, 34, 334, 0, 0, '', '2025-11-07T09:58:31.591588+00:00', '2025-11-07T09:58:31.591588+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('b19ab833-ee51-4e20-a04d-dc6dc77e3c33', '746c2bc5-0672-4178-9984-1f6c9a4435d4', 3508.23, 10.4, 34, 14, 34, 334, 0, 0, '', '2025-11-07T10:05:09.29592+00:00', '2025-11-07T10:05:09.29592+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('565d39f5-74e0-4cfd-8304-ee60db686ab1', '6df31cac-1ff0-4dd1-ab6c-7fd437a70528', 0, 20, 40, 14, 40, 386, 0, 0, '', '2025-11-12T08:58:28.610436+00:00', '2025-11-12T08:58:28.610436+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('2580ec33-bf5b-4a09-b344-73655ec04707', 'c15703ca-50d0-46eb-bcf9-54692df84492', 113.73, 20, 40, 14, 40, 386, 0, 0, '', '2025-11-12T09:05:41.092852+00:00', '2025-11-12T09:05:41.092852+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('132eea36-c749-422c-a001-39dc9b329db0', '810583fe-81b0-4146-ade7-7b6356dddded', 0, 20, 40, 14, 40, 386, 0, 0, '', '2025-11-12T09:11:02.406855+00:00', '2025-11-12T09:11:02.406855+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('60207254-30b1-4c72-944f-f06df8f0b0cc', '7725d35f-3e18-4e28-8e27-463a878f33cf', 849.59, 32, 33, 6.5, 33, 287, 0, 0, '', '2025-11-14T08:44:43.451329+00:00', '2025-11-14T08:44:43.451329+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('e76ca44c-2f1b-4838-b0f0-5c2835f99eed', '650e7146-94b7-490c-b06b-4ca6e4c047e0', 849.59, 32, 34, 6.5, 34, 127, 0, 0, '', '2025-11-14T08:47:25.234371+00:00', '2025-11-14T08:47:25.234371+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('816e6d2a-9057-4e64-bc27-d0549e055e79', '671a884b-d938-40c4-9b01-13f0bd7453a8', 703.77, 32, 34, 6.5, 34, 127, 0, 0, '', '2025-11-14T08:48:45.647689+00:00', '2025-11-14T08:48:45.647689+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('41aba0aa-81b0-409c-b334-60b03511eb55', 'e76e466f-4bce-4f6c-ab02-3ab4d7edc65a', 3456, 46, 36, 0, 0, 0, 0, 0, '', '2025-12-14T21:10:31.922298+00:00', '2025-12-14T21:10:31.922298+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('26bb27d4-199d-453a-8e21-89683c502978', '49b62d8c-b979-481d-913b-0a12ff98f802', 0, 2, 30, 2, 30, 60, 0, 0, '', '2025-12-30T08:59:43.457096+00:00', '2025-12-30T08:59:43.457096+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('865dcabf-8e2e-432c-abe7-9e7c79e4b8d7', '8eb03b5f-4b15-4499-bc3b-91321744c52f', 787876, 78, 55, 76, 44, 77667, 656, 767, 'gjhhj', '2026-01-08T02:28:12.648557+00:00', '2026-01-08T02:28:12.648557+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."workshop_costs" ("id", "analysis_id", "spare_parts_purchase_cost", "bodywork_actual_hours", "bodywork_hourly_cost", "painting_actual_hours", "painting_hourly_cost", "painting_consumables_cost", "subcontractor_costs", "other_costs", "notes", "created_at", "updated_at") VALUES ('6a81d2b2-12d4-441b-8e3d-0454280a60f8', '995507b9-539f-4ddb-b72c-0e473457a136', 1800, 29, 32, 29, 35, 900, 0, 0, '', '2026-02-05T17:59:59.632042+00:00', '2026-02-05T17:59:59.632042+00:00') ON CONFLICT DO NOTHING;

-- Data for system_settings
INSERT INTO public."system_settings" ("id", "setting_key", "setting_value", "description", "created_at", "updated_at", "updated_by") VALUES ('009d82ec-525f-474a-a5ea-93ff58ca3d53', 'billing_enabled', '{"value":true}', 'Si está habilitada la facturación por análisis adicionales', '2025-10-19T13:01:35.399561+00:00', '2025-10-19T13:01:35.399561+00:00', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."system_settings" ("id", "setting_key", "setting_value", "description", "created_at", "updated_at", "updated_by") VALUES ('5b6ca3fd-a06d-482e-8fe8-8b8a6d7b7958', 'company_info', '{"name":"Valora Plus","email":"","tax_id":"","address":""}', 'Información de la empresa para facturación', '2025-10-19T13:01:35.399561+00:00', '2025-10-19T13:01:35.399561+00:00', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."system_settings" ("id", "setting_key", "setting_value", "description", "created_at", "updated_at", "updated_by") VALUES ('f502d1da-26c3-4abb-8eb4-a1eac13a3c06', 'stripe_enabled', '{"value":true}', 'Si está habilitada la integración con Stripe', '2025-10-19T13:01:35.399561+00:00', '2025-10-19T13:01:35.399561+00:00', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."system_settings" ("id", "setting_key", "setting_value", "description", "created_at", "updated_at", "updated_by") VALUES ('4fd3825a-f8e3-4564-9b54-295ff8fc2ec6', 'additional_analysis_price', '{"value":15,"currency":"EUR"}', 'Precio por análisis adicional después del límite gratuito', '2025-10-19T13:01:35.399561+00:00', '2025-10-19T13:01:35.399561+00:00', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."system_settings" ("id", "setting_key", "setting_value", "description", "created_at", "updated_at", "updated_by") VALUES ('cca6c289-75c4-4b5e-8604-2ff500db5c27', 'stripe_publishable_key', '{"value":"pk_test_51SLeHmRPpBbS3vmfJ8laUa24Q2hKkF6Mfu0v8fviC9JaRTobIEO99J2ni14smLFzrhnWecVxqhVF10vac7cVdzqH00jqIiq5ai"}', NULL, '2025-10-24T17:34:47.194097+00:00', '2025-10-24T17:34:47.194097+00:00', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."system_settings" ("id", "setting_key", "setting_value", "description", "created_at", "updated_at", "updated_by") VALUES ('709b9ac2-3ec4-4fb9-9b3f-b1c80cf96e8d', 'monthly_free_analyses_limit', '{"value":3}', 'Límite de análisis gratuitos por mes para usuarios admin_mechanic', '2025-10-19T13:01:35.399561+00:00', '2025-10-24T23:08:39.76843+00:00', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212') ON CONFLICT DO NOTHING;

-- Data for user_monthly_usage
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('ffbf5154-2c75-40ef-8e70-b1679af24b42', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 2026, 7, 0, 'pending', NULL, '2026-07-08T19:14:04.555016+00:00', '2026-07-10T15:01:30.432554+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('a559fe65-9e70-4051-b8a2-19bf9e33f207', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 2026, 5, 0, 'pending', NULL, '2026-05-27T15:32:02.661524+00:00', '2026-05-28T19:22:34.801737+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('e8f2d2e8-e8ee-4a8b-8cdd-cfc2943e44a6', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 2026, 2, 0, 'pending', NULL, '2026-02-09T12:32:32.06821+00:00', '2026-02-16T15:55:20.815668+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('6c1a0c3f-93d1-4570-8b83-a54ed2bf6d09', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 2026, 7, 0, 'pending', NULL, '2026-07-10T14:40:16.866793+00:00', '2026-07-10T15:02:18.85514+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('a2ee78d0-e80c-4ce3-944a-d37771844a3f', '485e7cd8-74c1-42e3-bd6b-1cde5ffaeb6b', 2025, 10, 0, 'pending', NULL, '2025-10-24T11:58:58.962052+00:00', '2025-10-24T11:58:58.962052+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('d871ecf1-7e06-4dfd-ac6b-8e4341fdb94d', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 2025, 10, 0, 'pending', NULL, '2025-10-25T04:37:58.241575+00:00', '2025-10-25T04:37:58.241575+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('a57a8c6a-e79e-4cc8-8c8b-902547d7d2b3', '95eaba1c-5e43-4be5-8a48-e90e58b42cd0', 2025, 10, 0, 'pending', NULL, '2025-10-25T04:43:46.798305+00:00', '2025-10-25T04:43:46.798305+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('621c9db3-a62c-4121-90be-f9e1dfb8e45f', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 2025, 10, 30, 'pending', NULL, '2025-10-22T20:29:21.027044+00:00', '2025-10-25T11:45:27.661422+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('57f1b4eb-04e5-49aa-95de-f48aae8e8262', '8beae8ad-96f9-44aa-b799-b90b1691cd2b', 2025, 10, 0, 'pending', NULL, '2025-10-25T12:38:13.154328+00:00', '2025-10-25T12:38:13.154328+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('7eff07fe-1488-412d-8c2d-fef8be62591f', '09a91c7c-419d-4f9e-b7d4-d2607559c146', 2025, 10, 0, 'pending', NULL, '2025-10-26T07:44:22.437848+00:00', '2025-10-26T07:44:22.437848+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('38d39e0b-c652-48b4-83de-ec7b87473226', '40f338e1-54f7-4b46-9b6b-97c665d22285', 2025, 10, 0, 'pending', NULL, '2025-10-26T15:37:41.297956+00:00', '2025-10-26T15:37:41.297956+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('298506f8-464a-409b-8293-bfc6537d5a98', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 2025, 11, 0, 'pending', NULL, '2025-11-03T09:26:31.93427+00:00', '2025-11-03T09:26:31.93427+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('dc312fea-8ccc-4cfe-92f4-09f5cddd2f09', '7c97bc85-8ad5-4929-adcd-0326d183e374', 2025, 11, 0, 'pending', NULL, '2025-11-17T18:55:54.755642+00:00', '2025-11-17T18:55:54.755642+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('d4b76429-c109-49c1-abd1-bf6c8e75960a', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 2025, 11, 0, 'pending', NULL, '2025-11-20T22:11:36.920278+00:00', '2025-11-20T22:11:36.920278+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('3394bc1e-e647-47ce-9553-4fd479055fd4', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 2025, 12, 0, 'pending', NULL, '2025-12-02T13:35:35.413602+00:00', '2025-12-02T13:35:35.413602+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('137db19d-642c-4690-8022-30e0c2607f5b', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 2025, 12, 0, 'pending', NULL, '2025-12-03T17:33:28.906559+00:00', '2025-12-03T17:33:28.906559+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('dbbd952f-2d4c-468d-8d1a-1e28756a2858', 'b0c73890-3fdf-49f2-b4af-29530c8ad59a', 2025, 12, 0, 'pending', NULL, '2025-12-08T22:26:37.27651+00:00', '2025-12-08T22:26:37.27651+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('2473bb15-3d79-4ac2-9d5a-6b75b4da97d1', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 2026, 1, 0, 'pending', NULL, '2026-01-01T01:13:42.609993+00:00', '2026-01-01T01:13:42.609993+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('0be9d0be-2fc2-40e8-9a6f-ed7f98c54301', 'b0c73890-3fdf-49f2-b4af-29530c8ad59a', 2026, 1, 0, 'pending', NULL, '2026-01-08T02:17:31.241601+00:00', '2026-01-08T02:17:31.241601+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('701868cb-b5fe-4743-b93d-44d5f236da2b', 'e785f3eb-be32-4c2a-81fd-028031bb455b', 2026, 1, 0, 'pending', NULL, '2026-01-19T19:42:48.919003+00:00', '2026-01-19T19:42:48.919003+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('2ce6b2e1-bec7-42b7-9d2b-6a5bdd723237', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 2026, 1, 0, 'pending', NULL, '2026-01-29T10:54:33.413663+00:00', '2026-01-29T10:54:33.413663+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('c0e91c1c-5169-42d5-8c70-5cb43ea2dd25', '30e2ccb0-f8ad-45a7-b6dd-ed810c93f212', 2026, 2, 0, 'pending', NULL, '2026-02-05T17:56:41.617494+00:00', '2026-02-11T12:09:02.36171+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('6eb10749-dda1-4e83-87fb-417e10588c6b', 'b0c73890-3fdf-49f2-b4af-29530c8ad59a', 2026, 2, 0, 'pending', NULL, '2026-02-11T00:36:02.191866+00:00', '2026-02-12T03:08:03.34911+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('eb47c0b3-9d02-496f-8b7f-44feb1ecad72', 'e785f3eb-be32-4c2a-81fd-028031bb455b', 2026, 2, 0, 'pending', NULL, '2026-02-16T01:47:21.263139+00:00', '2026-02-16T01:47:21.263139+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('b04fd421-b16e-45c8-82f5-765a1f658a0f', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 2026, 6, 0, 'pending', NULL, '2026-06-03T16:17:52.191456+00:00', '2026-06-03T16:37:02.962202+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('3bcd13d3-0102-4ed0-ae6f-66888232e848', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 2026, 5, 0, 'pending', NULL, '2026-05-22T18:24:54.786406+00:00', '2026-05-22T21:20:45.391215+00:00') ON CONFLICT DO NOTHING;
-- Fila posterior al export incrustado, recuperada de c:\migracion\datos.sql
INSERT INTO public."user_monthly_usage" ("id", "user_id", "year", "month", "total_amount_due", "payment_status", "stripe_payment_intent_id", "created_at", "updated_at") VALUES ('c32cd944-ca2f-40bb-b488-d2b98c4e3a83', 'd9b71b6e-2f68-4132-b204-aa8b4b1916a0', 2026, 8, 0.00, 'pending', NULL, '2026-08-03 17:31:21.105071+00', '2026-08-03 17:32:15.939726+00') ON CONFLICT DO NOTHING;

-- Data for payments
INSERT INTO public."payments" ("id", "workshop_id", "user_id", "stripe_payment_intent_id", "stripe_session_id", "stripe_customer_id", "amount_cents", "currency", "status", "analysis_month", "analyses_purchased", "unit_price_cents", "payment_method", "stripe_fee_cents", "net_amount_cents", "description", "created_at", "paid_at", "updated_at", "package_id") VALUES ('424dcce5-6c2b-4c91-8fda-a98483d691b0', 'c378f51e-ec17-42b6-be0d-142865116848', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'cs_test_a1ar9mglDOlxPBKaWYP7RDqDYr27h0s2ws9kEY1249OxpwWmGXaYQmKpss', 'cs_test_a1ar9mglDOlxPBKaWYP7RDqDYr27h0s2ws9kEY1249OxpwWmGXaYQmKpss', NULL, 20000, 'eur', 'completed', '2025-10', 25, 800, 'card', 0, 0, 'Pack Básico - 25 análisis', '2025-10-24T20:31:02.119502+00:00', '2025-10-24T20:31:27.205952+00:00', '2025-10-24T20:31:27.205952+00:00', 'fd6cf13c-5a6d-4c24-91fb-cc4e7832ee3f') ON CONFLICT DO NOTHING;
INSERT INTO public."payments" ("id", "workshop_id", "user_id", "stripe_payment_intent_id", "stripe_session_id", "stripe_customer_id", "amount_cents", "currency", "status", "analysis_month", "analyses_purchased", "unit_price_cents", "payment_method", "stripe_fee_cents", "net_amount_cents", "description", "created_at", "paid_at", "updated_at", "package_id") VALUES ('b091e34d-91f7-4e9a-a5bd-fad1c1dd4780', 'c378f51e-ec17-42b6-be0d-142865116848', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'cs_test_a14sxBpfxkp8EfoVSZ1mzT6ByezmVEwXsJWMO8zRI4j8Afv4pi15wEPXDv', 'cs_test_a14sxBpfxkp8EfoVSZ1mzT6ByezmVEwXsJWMO8zRI4j8Afv4pi15wEPXDv', NULL, 1000, 'eur', 'pending', '2025-10', 1, 1000, NULL, NULL, NULL, 'Pack Individual - 1 análisis', '2025-10-24T20:50:20.411839+00:00', NULL, '2025-10-24T20:50:20.411839+00:00', '0c1a531a-5221-4496-9a33-3c8eea2dd70c') ON CONFLICT DO NOTHING;
INSERT INTO public."payments" ("id", "workshop_id", "user_id", "stripe_payment_intent_id", "stripe_session_id", "stripe_customer_id", "amount_cents", "currency", "status", "analysis_month", "analyses_purchased", "unit_price_cents", "payment_method", "stripe_fee_cents", "net_amount_cents", "description", "created_at", "paid_at", "updated_at", "package_id") VALUES ('c9b860ea-51de-46e6-9350-224ddf852c60', 'c378f51e-ec17-42b6-be0d-142865116848', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'cs_test_a1tTCLvfpzeXH89nGfA0Ze6Wo21xopBbU8Ri2HxTuFflXBCdXVnPEObUVz', 'cs_test_a1tTCLvfpzeXH89nGfA0Ze6Wo21xopBbU8Ri2HxTuFflXBCdXVnPEObUVz', NULL, 20000, 'eur', 'completed', '2025-10', 25, 800, 'card', 0, 0, 'Pack Básico - 25 análisis', '2025-10-24T20:51:31.477145+00:00', '2025-10-24T20:51:53.988027+00:00', '2025-10-24T20:51:53.988027+00:00', 'fd6cf13c-5a6d-4c24-91fb-cc4e7832ee3f') ON CONFLICT DO NOTHING;
INSERT INTO public."payments" ("id", "workshop_id", "user_id", "stripe_payment_intent_id", "stripe_session_id", "stripe_customer_id", "amount_cents", "currency", "status", "analysis_month", "analyses_purchased", "unit_price_cents", "payment_method", "stripe_fee_cents", "net_amount_cents", "description", "created_at", "paid_at", "updated_at", "package_id") VALUES ('aa0c397b-8d75-454c-af63-6185062d79c8', '83899a7d-7f95-4033-aa91-71cb0b9ecdbf', '95eaba1c-5e43-4be5-8a48-e90e58b42cd0', 'cs_live_a1g8cllTJQesrL8tj417rytMT9heNfVJO6fVVwZ96VjFQBUfbMyIvoQ4ed', 'cs_live_a1g8cllTJQesrL8tj417rytMT9heNfVJO6fVVwZ96VjFQBUfbMyIvoQ4ed', NULL, 1000, 'eur', 'completed', '2025-10', 1, 1000, 'card', 0, 0, 'Pack Individual - 1 análisis', '2025-10-25T04:46:11.864632+00:00', '2025-10-25T04:46:48.430065+00:00', '2025-10-25T04:46:48.430065+00:00', '0c1a531a-5221-4496-9a33-3c8eea2dd70c') ON CONFLICT DO NOTHING;
INSERT INTO public."payments" ("id", "workshop_id", "user_id", "stripe_payment_intent_id", "stripe_session_id", "stripe_customer_id", "amount_cents", "currency", "status", "analysis_month", "analyses_purchased", "unit_price_cents", "payment_method", "stripe_fee_cents", "net_amount_cents", "description", "created_at", "paid_at", "updated_at", "package_id") VALUES ('deb69fe8-b689-4750-9932-40fd5514b2aa', '83899a7d-7f95-4033-aa91-71cb0b9ecdbf', '95eaba1c-5e43-4be5-8a48-e90e58b42cd0', 'cs_live_a1HsXVXzBsz8hLxHlpIcBRIwaingZ7FiPI9vfZPBIx5A9eG8uNMydhEdqh', 'cs_live_a1HsXVXzBsz8hLxHlpIcBRIwaingZ7FiPI9vfZPBIx5A9eG8uNMydhEdqh', NULL, 1000, 'eur', 'completed', '2025-10', 1, 1000, 'card', 0, 0, 'Pack Individual - 1 análisis', '2025-10-25T04:48:33.248016+00:00', '2025-10-25T04:48:50.089317+00:00', '2025-10-25T04:48:50.089317+00:00', '0c1a531a-5221-4496-9a33-3c8eea2dd70c') ON CONFLICT DO NOTHING;
INSERT INTO public."payments" ("id", "workshop_id", "user_id", "stripe_payment_intent_id", "stripe_session_id", "stripe_customer_id", "amount_cents", "currency", "status", "analysis_month", "analyses_purchased", "unit_price_cents", "payment_method", "stripe_fee_cents", "net_amount_cents", "description", "created_at", "paid_at", "updated_at", "package_id") VALUES ('1f9c85c7-7647-488d-9d4e-c9303e5e4e4d', 'c378f51e-ec17-42b6-be0d-142865116848', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'cs_live_a1aHPQzF2h54GHMOIZcSggDrBudx46msLtVw375uB5R4E7SnSsGI1qsxSt', 'cs_live_a1aHPQzF2h54GHMOIZcSggDrBudx46msLtVw375uB5R4E7SnSsGI1qsxSt', NULL, 1000, 'eur', 'canceled', '2025-10', 1, 1000, NULL, NULL, NULL, 'Pack Individual - 1 análisis', '2025-10-24T20:20:24.141787+00:00', NULL, '2025-10-25T20:20:25.089363+00:00', '0c1a531a-5221-4496-9a33-3c8eea2dd70c') ON CONFLICT DO NOTHING;
INSERT INTO public."payments" ("id", "workshop_id", "user_id", "stripe_payment_intent_id", "stripe_session_id", "stripe_customer_id", "amount_cents", "currency", "status", "analysis_month", "analyses_purchased", "unit_price_cents", "payment_method", "stripe_fee_cents", "net_amount_cents", "description", "created_at", "paid_at", "updated_at", "package_id") VALUES ('e6dda2ca-a9b0-4960-b5e5-5fa429e887a0', 'c378f51e-ec17-42b6-be0d-142865116848', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'cs_live_a1S6MBJSByfo4jqnzpSsntQOxpBiDBiphFYxDYeKtsAlu10BCLWy3aQFJr', 'cs_live_a1S6MBJSByfo4jqnzpSsntQOxpBiDBiphFYxDYeKtsAlu10BCLWy3aQFJr', NULL, 1000, 'eur', 'canceled', '2025-10', 1, 1000, NULL, NULL, NULL, 'Pack Individual - 1 análisis', '2025-10-24T23:06:28.968007+00:00', NULL, '2025-10-25T23:06:29.80892+00:00', '0c1a531a-5221-4496-9a33-3c8eea2dd70c') ON CONFLICT DO NOTHING;
INSERT INTO public."payments" ("id", "workshop_id", "user_id", "stripe_payment_intent_id", "stripe_session_id", "stripe_customer_id", "amount_cents", "currency", "status", "analysis_month", "analyses_purchased", "unit_price_cents", "payment_method", "stripe_fee_cents", "net_amount_cents", "description", "created_at", "paid_at", "updated_at", "package_id") VALUES ('37964662-9fe9-4873-9ab4-01717d8e3167', 'c378f51e-ec17-42b6-be0d-142865116848', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 'cs_live_a1lNuW2Tpt0bBwHVIMakjviSrwtjlxmgM17DFxIGKWY86CfqPiVp1jeKOd', 'cs_live_a1lNuW2Tpt0bBwHVIMakjviSrwtjlxmgM17DFxIGKWY86CfqPiVp1jeKOd', NULL, 20000, 'eur', 'canceled', '2025-10', 25, 800, NULL, NULL, NULL, 'Pack Básico - 25 análisis', '2025-10-25T11:51:39.438292+00:00', NULL, '2025-10-26T11:51:39.805104+00:00', 'fd6cf13c-5a6d-4c24-91fb-cc4e7832ee3f') ON CONFLICT DO NOTHING;

-- Data for user_paid_analyses_balance
INSERT INTO public."user_paid_analyses_balance" ("id", "user_id", "remaining_analyses", "total_purchased", "total_used", "package_type", "purchase_history", "created_at", "updated_at") VALUES ('76b6b65a-89c3-4730-96c7-2af390bf4eea', '2ccb2fcc-314f-4efa-8d6a-fb44862a48e1', 0, 158, 171, 'Pack Básico', '[{"date":"2025-10-23T15:10:16.800325+00:00","amount_paid":20000,"package_type":"Pack Básico","analyses_count":25,"stripe_payment_intent_id":"cs_test_a1kQNajRwlnWusmWZDLA4gz40gJd3TpqA4cAfH5CYe6quqQACTnI5yRLSN"},{"date":"2025-10-23T15:11:08.438311+00:00","amount_paid":1000,"package_type":"Pack Individual","analyses_count":1,"stripe_payment_intent_id":"cs_test_a1wgt9vZcXfkLlNu3XKodkhb7uzRud8HQsEeGzC01fDHxdVrkEq6147P6j"},{"date":"2025-10-23T17:18:04.871793+00:00","amount_paid":1000,"package_type":"Pack Individual","analyses_count":1,"stripe_payment_intent_id":"cs_test_a1V0G6mv00r7cqDOZNWxrguuGQgWGm4wRPagjwyHjamDtcVSZNMa6I7exB"},{"date":"2025-10-23T17:31:52.591916+00:00","amount_paid":20000,"package_type":"Pack Básico","analyses_count":25,"stripe_payment_intent_id":"cs_test_a1JvZo9RfCGTS7nX2QihTqSx9Mm3LKneu6ZTiEOGnbRVK91fNwA71MMxO6"},{"date":"2025-10-24T03:30:14.953725+00:00","amount_paid":20000,"package_type":"Pack Básico","analyses_count":25,"stripe_payment_intent_id":"cs_test_a1sP6jss4NZRiOKOrS8Z2rUEKNsxfoHJhaDulFIbkqE2tMtd1wRZDu7kgd"},{"date":"2025-10-24T05:52:52.917809+00:00","amount_paid":1000,"package_type":"Pack Individual","analyses_count":1,"stripe_payment_intent_id":"cs_test_a1ovaxm4gRljBepltpjQJzPFcH0JXMI4dW6QB9fQxfYCR5DXyy0kU0LngJ"},{"date":"2025-10-24T15:39:41.001596+00:00","amount_paid":1000,"package_type":"Pack Individual","analyses_count":1,"stripe_payment_intent_id":"cs_test_a1svXaZd9owBO07N3lSuLR1t59mobSlmcw2LTZVZbZ11kfQ7yFgc4NNBb9"},{"date":"2025-10-24T16:43:03.914731+00:00","amount_paid":1000,"package_type":"Pack Individual","analyses_count":1,"stripe_payment_intent_id":"cs_test_a1A0QPYUkbtMrYyVxDtELuREdNiCH52ecQsoVuMaom3xs7wGS2zPo290sN"},{"date":"2025-10-24T17:15:18.996703+00:00","amount_paid":1000,"package_type":"Pack Individual","analyses_count":1,"stripe_payment_intent_id":"cs_test_a1GESd4xKRugAGSGRCXHh91OK635rLY2cKufdync2ZCEi5rDNuDMzmkp6x"},{"date":"2025-10-24T17:27:04.150906+00:00","amount_paid":20000,"package_type":"Pack Básico","analyses_count":25,"stripe_payment_intent_id":"cs_test_a1zm0A3aupzDBp1rAz4AciYAfJVfi4kWH7eaNQBA4TO1S1wlyaRDknC3GL"},{"date":"2025-10-24T17:43:18.621076+00:00","amount_paid":1000,"package_type":"Pack Individual","analyses_count":1,"stripe_payment_intent_id":"cs_test_a1fYCVusu0EqqKEctkFsJrgKrWlPldcPmMWF3JOHdyjfxcAwhunSIVdmv6"},{"date":"2025-10-24T17:58:01.851524+00:00","amount_paid":10,"package_type":"Pack Individual","analyses_count":1,"stripe_payment_intent_id":"cs_test_a1JuYpJpkpMAbZPmVnd38uOMsY7VtU6eeoYkYzTxmPEZh94nYlZEWq1l8j"},{"date":"2025-10-24T20:31:27.205952+00:00","amount_paid":200,"package_type":"Pack Básico","analyses_count":25,"stripe_payment_intent_id":"cs_test_a1ar9mglDOlxPBKaWYP7RDqDYr27h0s2ws9kEY1249OxpwWmGXaYQmKpss"},{"date":"2025-10-24T20:51:53.988027+00:00","amount_paid":200,"package_type":"Pack Básico","analyses_count":25,"stripe_payment_intent_id":"cs_test_a1tTCLvfpzeXH89nGfA0Ze6Wo21xopBbU8Ri2HxTuFflXBCdXVnPEObUVz"}]', '2025-10-23T15:10:16.800325+00:00', '2026-02-16T11:33:32.310066+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."user_paid_analyses_balance" ("id", "user_id", "remaining_analyses", "total_purchased", "total_used", "package_type", "purchase_history", "created_at", "updated_at") VALUES ('ee82d875-615b-4d0c-a5b2-f0956a9368e5', '95eaba1c-5e43-4be5-8a48-e90e58b42cd0', 1, 2, 1, 'Pack Individual', '[{"date":"2025-10-25T04:46:48.430065+00:00","amount_paid":10,"package_type":"Pack Individual","analyses_count":1,"stripe_payment_intent_id":"cs_live_a1g8cllTJQesrL8tj417rytMT9heNfVJO6fVVwZ96VjFQBUfbMyIvoQ4ed"},{"date":"2025-10-25T04:48:50.089317+00:00","amount_paid":10,"package_type":"Pack Individual","analyses_count":1,"stripe_payment_intent_id":"cs_live_a1HsXVXzBsz8hLxHlpIcBRIwaingZ7FiPI9vfZPBIx5A9eG8uNMydhEdqh"}]', '2025-10-25T04:46:48.430065+00:00', '2025-10-25T04:54:39.43359+00:00') ON CONFLICT DO NOTHING;

-- Data for analysis_packages
INSERT INTO public."analysis_packages" ("id", "name", "analyses_count", "price_per_analysis", "total_price", "discount_percentage", "is_active", "sort_order", "created_at", "updated_at") VALUES ('fd6cf13c-5a6d-4c24-91fb-cc4e7832ee3f', 'Pack Básico', 25, 800, 20000, 20, true, 2, '2025-10-22T21:24:42.177046+00:00', '2025-10-22T21:24:42.177046+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis_packages" ("id", "name", "analyses_count", "price_per_analysis", "total_price", "discount_percentage", "is_active", "sort_order", "created_at", "updated_at") VALUES ('1d93da11-ca73-43cf-8fd9-6b8ea0a668ed', 'Pack Profesional', 50, 650, 32500, 35, true, 3, '2025-10-22T21:24:42.177046+00:00', '2025-10-22T21:24:42.177046+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis_packages" ("id", "name", "analyses_count", "price_per_analysis", "total_price", "discount_percentage", "is_active", "sort_order", "created_at", "updated_at") VALUES ('5b08389f-215e-4d66-bcbd-f9ea3bcfdf7c', 'Pack Enterprise', 100, 500, 50000, 50, true, 4, '2025-10-22T21:24:42.177046+00:00', '2025-10-22T21:24:42.177046+00:00') ON CONFLICT DO NOTHING;
INSERT INTO public."analysis_packages" ("id", "name", "analyses_count", "price_per_analysis", "total_price", "discount_percentage", "is_active", "sort_order", "created_at", "updated_at") VALUES ('0c1a531a-5221-4496-9a33-3c8eea2dd70c', 'Pack Individual', 1, 1000, 1000, 0, true, 1, '2025-10-22T21:24:42.177046+00:00', '2025-10-24T16:25:45.850766+00:00') ON CONFLICT DO NOTHING;

-- ---------------------------------------------------------------------------
-- Reactivar el trigger de conteo de analisis, una vez cargado el historico
-- ---------------------------------------------------------------------------
ALTER TABLE analysis ENABLE TRIGGER trigger_analysis_count_increment;

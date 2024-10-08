PGDMP                       |         
   notatki_db    16.2 (Debian 16.2-1.pgdg120+2)    16.3     D           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            E           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            F           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            G           1262    16459 
   notatki_db    DATABASE     u   CREATE DATABASE notatki_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
    DROP DATABASE notatki_db;
                user    false            �            1259    43316    friends    TABLE     X   CREATE TABLE public.friends (
    user_id uuid NOT NULL,
    friend_id uuid NOT NULL
);
    DROP TABLE public.friends;
       public         heap    user    false            �            1259    43319    notes    TABLE     �   CREATE TABLE public.notes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    title character varying(255) NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.notes;
       public         heap    user    false            �            1259    43326    roles    TABLE     x   CREATE TABLE public.roles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL
);
    DROP TABLE public.roles;
       public         heap    user    false            �            1259    43330    shared_notes    TABLE     �   CREATE TABLE public.shared_notes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    note_id uuid,
    shared_with_user_id uuid,
    shared_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
     DROP TABLE public.shared_notes;
       public         heap    user    false            �            1259    43335    users    TABLE     �  CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    login character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role_id uuid,
    profile_picture character varying(255) DEFAULT 'public/img/profile/default/default_profile_picture.jpg'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.users;
       public         heap    user    false            =          0    43316    friends 
   TABLE DATA           5   COPY public.friends (user_id, friend_id) FROM stdin;
    public          user    false    215   -        >          0    43319    notes 
   TABLE DATA           H   COPY public.notes (id, user_id, title, content, created_at) FROM stdin;
    public          user    false    216   �        ?          0    43326    roles 
   TABLE DATA           )   COPY public.roles (id, name) FROM stdin;
    public          user    false    217   �%       @          0    43330    shared_notes 
   TABLE DATA           S   COPY public.shared_notes (id, note_id, shared_with_user_id, shared_at) FROM stdin;
    public          user    false    218   Y&       A          0    43335    users 
   TABLE DATA           a   COPY public.users (id, login, email, password, role_id, profile_picture, created_at) FROM stdin;
    public          user    false    219   6(       �           2606    43344    friends friends_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.friends
    ADD CONSTRAINT friends_pkey PRIMARY KEY (user_id, friend_id);
 >   ALTER TABLE ONLY public.friends DROP CONSTRAINT friends_pkey;
       public            user    false    215    215            �           2606    43346    notes notes_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.notes DROP CONSTRAINT notes_pkey;
       public            user    false    216            �           2606    43348    roles roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public            user    false    217            �           2606    43350    shared_notes shared_notes_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.shared_notes
    ADD CONSTRAINT shared_notes_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.shared_notes DROP CONSTRAINT shared_notes_pkey;
       public            user    false    218            �           2606    43352    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            user    false    219            �           2606    43354    users users_login_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key UNIQUE (login);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_login_key;
       public            user    false    219            �           2606    43356    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            user    false    219            �           2606    43357    friends friends_friend_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.friends
    ADD CONSTRAINT friends_friend_id_fkey FOREIGN KEY (friend_id) REFERENCES public.users(id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.friends DROP CONSTRAINT friends_friend_id_fkey;
       public          user    false    215    3239    219            �           2606    43362    friends friends_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.friends
    ADD CONSTRAINT friends_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.friends DROP CONSTRAINT friends_user_id_fkey;
       public          user    false    219    215    3239            �           2606    43367    notes notes_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.notes DROP CONSTRAINT notes_user_id_fkey;
       public          user    false    3239    216    219            �           2606    43372 &   shared_notes shared_notes_note_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.shared_notes
    ADD CONSTRAINT shared_notes_note_id_fkey FOREIGN KEY (note_id) REFERENCES public.notes(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.shared_notes DROP CONSTRAINT shared_notes_note_id_fkey;
       public          user    false    218    3229    216            �           2606    43377 2   shared_notes shared_notes_shared_with_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.shared_notes
    ADD CONSTRAINT shared_notes_shared_with_user_id_fkey FOREIGN KEY (shared_with_user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.shared_notes DROP CONSTRAINT shared_notes_shared_with_user_id_fkey;
       public          user    false    3239    218    219            �           2606    43382    users users_role_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE SET NULL;
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_role_id_fkey;
       public          user    false    219    3231    217            =   �   x����C1C�x��g�a�4��#$#�H�J��C��Н��_��ZG,;��kPw������d�N�0c+
�ltC
ʌ4��V����r�LS&�����g���`={�@���N$��M��M��jݍ鏏O�`z��G
Qhx s�ТY=ڍ��ϻ��(�j      >     x��Uϊ�6?�<�.��YI�-y��6%���-���Y����<v�TBC����E��e�E�$���%�$��flI����(�6��[��kLb�eFq�Mi&S��E$$�S��(��9O�t�Ei��\�$��s��eW������h������ӿ6O6�\��<0(ۡ�-��P��m�2�=��u�-l�޲Cq����?VE_�X�C[�B6��ulߌ82�Xv�_-�P���KɄX�d��U$D�襔&u�B�[�r�rP�F{$.>�����)ڱl
���>k�vpc}B����'�<l�I!������7K�=�C�u����6�&,��8�:�l^]~��3�����]ᆯ(�U�E���K�t�Z�XM�'�k9Z�2�j뵾�"�t�+�������M>U�F�`����W}'�o�f�E�H�v�
���GV�fմש0?m�@� �9R�潮�:�E�s��߇���nN�g�3�h�0�P�_���t�����8c*�-�����f-�Uj"��2A�;-�
��y&l�S���:4Y*�'�o�\QC�k���P�/���Ѹ� �=ք�r�n��a?E&�Mh���o�8�Ų�[���i��m�Ǵ��2.I�G+v��p�Tvk쭧�9%�L��5��mI�ϧ��tB���ձ����L�wm#��W4�fYe�\z+1@N�,���)�8Iy���.e�[8��0%clf�NcG�s�"�S��,WbK����q��u[��R�����(��pI�S����6�����LQݐ+���&MU��d���0=���%,~�� Fz��������ƚ��5cG�����<A��ZG��&��Kt1M q��:V�R��
H���1�K�9��+`�W��'<��
6?�eS"	�$�.P���m����>�%ձ��9*__�G5�g����5��(W4�:�+����v�"�C�N��k�V��R.c��4���X�#�4�c��ħF(���L@pg3��N929r�OVJm!]����[�y��`��*��eRö��4ʲ�w~�fM�&��.u,���,0*CVj�ld�ѥ�z��b��]�y|mO�����S�j�+i��K��1
my�]~���Ei9Y�U>�ޏ�����Zl�vX���}�Bג�+vg=�n���o��\l���痗U8�^2C��@�̄���L�4��te�)�R�̣D��vZ(ϵN)z.��:p12��"Υ[�c[�ȞlBǟV�5����]�Y��@6�v��) j�^i!T-_-���kO�      ?   T   x����0�:��(&�]h?G�����I���RE9+"��#��&u���{����)�s�9[�d�w��VG	���؈�qy�      @   �  x���K�$)EǑ��8el�O��&`���P��Yפ� !����W"��Ž�����d�g�p>�G�Z�HAl��[�<c�[>�c���ʽՅ8#!9B�bꭇ�0`�?��!oB<^̹]��F�_ 1�ƛ�����( �M��$�峟�iGΏHƇ�����6݀��A\n1V�dv�䩜.��A&]��f�K\zp�ٓX�
˷���vvW_<�׸e�L{�k��,��;��l�3a}��U���g�ذM���D�t�;�i��0$�9��;ș���pPU���L�G0��֩U�?I~��_n���5�
h~�XOǹ�Ӥ1�o�G��Bq�B�
�8���c�r:�}y����Dߔ�����/�;�o����E��+����s��Ki:Z�ֳQ��O��k]g��$�-��#�t!���(�?���v��C|�I�#�11����z�~���      A   �  x���[o;ǟw?E����O
�&@ȥՑ*�=�%�lnY>}�'�tEUN�idy�?�h�Ў� ��#��rf ��@� ��yb��(��㿚��69���g#=�b1�Ы�������X�������_����u'�çX�3__�F��'���q�}S�y<�'.W҈����p�b�lU�](6��l���o��ߪ���u�L(�a��@Y��6��V�s�b�$H���94e�AV@:(/��I��.���b@����:E/�p.�x8�םH���[Vմ��o�hF��U1�{	�{I,��cd|��Y0�H�}�-n�\~�\�6eWB*�:��Hdu�7¡���FslI ���~���%yo3�<���k��`ڴ�x�gٸ������E��G�Y)0o�L\Љ}7�[������`��H�j<(��q�A{��<0���c�U�T����u_�����i��f���x>^dˎ������k�T����,��<ޗv�n��?��הgR`�d�0��Q�8��MY�c�p���-��=�KX�D��������^�q�7�w��jR^��液�ѝ=<�y,	����k�n3�i&�����e�Yc�4o9��v�! ��X⒧��u^R�_nEܗ�un����OwW'?��[ջt�T^�0�uG�5��{|�u|7�[��NM>`ܦ��u&)�ڤ�di������     
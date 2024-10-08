PGDMP  7                     |         
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
                user    false            �            1259    43244    friends    TABLE     X   CREATE TABLE public.friends (
    user_id uuid NOT NULL,
    friend_id uuid NOT NULL
);
    DROP TABLE public.friends;
       public         heap    user    false            �            1259    43247    notes    TABLE     �   CREATE TABLE public.notes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    title character varying(255) NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.notes;
       public         heap    user    false            �            1259    43254    roles    TABLE     x   CREATE TABLE public.roles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL
);
    DROP TABLE public.roles;
       public         heap    user    false            �            1259    43258    shared_notes    TABLE     �   CREATE TABLE public.shared_notes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    note_id uuid,
    shared_with_user_id uuid,
    shared_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
     DROP TABLE public.shared_notes;
       public         heap    user    false            �            1259    43263    users    TABLE     �  CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    login character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role_id uuid,
    profile_picture character varying(255) DEFAULT 'public/img/profile/default/default_profile_picture.jpg'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.users;
       public         heap    user    false            =          0    43244    friends 
   TABLE DATA           5   COPY public.friends (user_id, friend_id) FROM stdin;
    public          user    false    215   -        >          0    43247    notes 
   TABLE DATA           H   COPY public.notes (id, user_id, title, content, created_at) FROM stdin;
    public          user    false    216   �        ?          0    43254    roles 
   TABLE DATA           )   COPY public.roles (id, name) FROM stdin;
    public          user    false    217   �        @          0    43258    shared_notes 
   TABLE DATA           S   COPY public.shared_notes (id, note_id, shared_with_user_id, shared_at) FROM stdin;
    public          user    false    218   5!       A          0    43263    users 
   TABLE DATA           a   COPY public.users (id, login, email, password, role_id, profile_picture, created_at) FROM stdin;
    public          user    false    219   R!       �           2606    43272    friends friends_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.friends
    ADD CONSTRAINT friends_pkey PRIMARY KEY (user_id, friend_id);
 >   ALTER TABLE ONLY public.friends DROP CONSTRAINT friends_pkey;
       public            user    false    215    215            �           2606    43274    notes notes_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.notes DROP CONSTRAINT notes_pkey;
       public            user    false    216            �           2606    43276    roles roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public            user    false    217            �           2606    43278    shared_notes shared_notes_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.shared_notes
    ADD CONSTRAINT shared_notes_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.shared_notes DROP CONSTRAINT shared_notes_pkey;
       public            user    false    218            �           2606    43280    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            user    false    219            �           2606    43282    users users_login_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key UNIQUE (login);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_login_key;
       public            user    false    219            �           2606    43284    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            user    false    219            �           2606    43285    friends friends_friend_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.friends
    ADD CONSTRAINT friends_friend_id_fkey FOREIGN KEY (friend_id) REFERENCES public.users(id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.friends DROP CONSTRAINT friends_friend_id_fkey;
       public          user    false    219    3239    215            �           2606    43290    friends friends_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.friends
    ADD CONSTRAINT friends_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.friends DROP CONSTRAINT friends_user_id_fkey;
       public          user    false    219    3239    215            �           2606    43295    notes notes_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.notes DROP CONSTRAINT notes_user_id_fkey;
       public          user    false    3239    219    216            �           2606    43300 &   shared_notes shared_notes_note_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.shared_notes
    ADD CONSTRAINT shared_notes_note_id_fkey FOREIGN KEY (note_id) REFERENCES public.notes(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.shared_notes DROP CONSTRAINT shared_notes_note_id_fkey;
       public          user    false    3229    216    218            �           2606    43305 2   shared_notes shared_notes_shared_with_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.shared_notes
    ADD CONSTRAINT shared_notes_shared_with_user_id_fkey FOREIGN KEY (shared_with_user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.shared_notes DROP CONSTRAINT shared_notes_shared_with_user_id_fkey;
       public          user    false    3239    218    219            �           2606    43310    users users_role_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE SET NULL;
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_role_id_fkey;
       public          user    false    217    219    3231            =   w   x��̱C!�:��r0"�.i a��~s�K�R��(pn��.h�+V����h��g���?հ;��ؚR�=����L�
��n�6e��u�M�SqϾ� �=�腒U��H���{���;�      >      x������ � �      ?   T   x����0�:��(&�]h?G�����I���RE9+"��#��&u���{����)�s�9[�d�w��VG	���؈�qy�      @      x������ � �      A   `  x����O�0����b�:��K�>Q��^`kz6MB�}ܦ�4���e+HB���ɲt~�9�qiv�-b�(�
v8u�$:���ő���&8���O�r ����]��v���0=_���ѬS<�W�I+��W_,#[}��)-PF Q�0bFں���Y KL�Ń�g��4�ͼQ�._CÂ�~�����en�~Ѳ�1��
�%�MƛDD2��+#@h��̠n�҉$]b�¤V��������n�����l�m�_�^
�=��˖'	䛛�hZVq9�f~D$%��"W�pȬ�� 1m1R����TBDl�~K�#i_>�a�i3�K�HHh0�%���DLq�2�4+ɰ&�`��:�y{=n�t��Y���=\�4T)�~4\',�U�)-8���x�?m����S)���8�3$�"��:��	�2G
F�K��"/a�\^�W����)c��ɬ߸�;L�yK��pww��zU|����1���0�7�~���O����Hp��)&Z�� F��nK2T)�6�A���#_�*���mG�@�o\��<�U>Ķ�,��ĝ��J��_��J�}Ap�iُ�}oѲIY$)�X���07mX     
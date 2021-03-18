﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Security.Cryptography;


public class Criptografia
{
    private readonly ICryptoTransform _decryptor;

    private readonly ICryptoTransform _encryptor;

    private static String senha;

    private static readonly byte[] IV = Encoding.UTF8.GetBytes("ThisIsUrPassword");

    private readonly byte[] _password;

    private readonly RijndaelManaged _cipher;

    private ICryptoTransform Decryptor { get { return _decryptor; } }
    private ICryptoTransform Encryptor { get { return _encryptor; } }

    public Criptografia(string password)
    {
        
        var md5 = new MD5CryptoServiceProvider();
        _password = md5.ComputeHash(Encoding.UTF8.GetBytes(password));

        //Initialize objects
        _cipher = new RijndaelManaged();
        _cipher.Padding = PaddingMode.PKCS7;
        _decryptor = _cipher.CreateDecryptor(_password, IV);
        _encryptor = _cipher.CreateEncryptor(_password, IV);
    }

    public string Encrypt(string text)
    {
        try
        {
            var buffer = Encoding.UTF8.GetBytes(text);
            return Convert.ToBase64String(Encryptor.TransformFinalBlock(buffer, 0, buffer.Length));
        }
        catch (ArgumentException ae)
        {
            Console.WriteLine("inputCount uses an invalid value or inputBuffer has an invalid offset length. " + ae);
            return null;
        }
        catch (ObjectDisposedException oe)
        {
            Console.WriteLine("The object has already been disposed." + oe);
            return null;
        }

    }

    public string Decrypt(string text)
    {
        try
        {
            byte[] input = Convert.FromBase64String(text);

            var newClearData = Decryptor.TransformFinalBlock(input, 0, input.Length);
            return Encoding.UTF8.GetString(newClearData);
        }
        catch (ArgumentException ae)
        {
            Console.WriteLine("inputCount uses an invalid value or inputBuffer has an invalid offset length. " + ae);
            return null;
        }
        catch (ObjectDisposedException oe)
        {
            Console.WriteLine("The object has already been disposed." + oe);
            return null;
        }


    }
}
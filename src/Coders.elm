module Coders exposing (..)

import Json.Encode
import Json.Decode
import Json.Decode.Pipeline


type alias ArticleList =
    { articles : List ArticleArticle
    }


type alias Article =
    { article : ArticleArticle
    }


type alias ArticleArticleAuthor =
    { username : String
    , bio : Maybe String
    , image : String
    , following : Bool
    }


type alias ArticleArticle =
    { title : String
    , slug : String
    , body : String
    , createdAt : String
    , updatedAt : String
    , tagList : List String
    , description : String
    , author : ArticleArticleAuthor
    , favorited : Bool
    , favoritesCount : Int
    }


decodeArticleList : Json.Decode.Decoder ArticleList
decodeArticleList =
    Json.Decode.Pipeline.decode ArticleList
        |> Json.Decode.Pipeline.required "articles" (Json.Decode.list decodeArticleArticle)


decodeArticle : Json.Decode.Decoder Article
decodeArticle =
    Json.Decode.Pipeline.decode Article
        |> Json.Decode.Pipeline.required "article" (decodeArticleArticle)


decodeArticleArticleAuthor : Json.Decode.Decoder ArticleArticleAuthor
decodeArticleArticleAuthor =
    Json.Decode.Pipeline.decode ArticleArticleAuthor
        |> Json.Decode.Pipeline.required "username" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "bio" (Json.Decode.maybe Json.Decode.string)
        |> Json.Decode.Pipeline.required "image" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "following" (Json.Decode.bool)


decodeArticleArticle : Json.Decode.Decoder ArticleArticle
decodeArticleArticle =
    Json.Decode.Pipeline.decode ArticleArticle
        |> Json.Decode.Pipeline.required "title" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "slug" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "body" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "createdAt" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "updatedAt" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "tagList" (Json.Decode.list Json.Decode.string)
        |> Json.Decode.Pipeline.required "description" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "author" (decodeArticleArticleAuthor)
        |> Json.Decode.Pipeline.required "favorited" (Json.Decode.bool)
        |> Json.Decode.Pipeline.required "favoritesCount" (Json.Decode.int)

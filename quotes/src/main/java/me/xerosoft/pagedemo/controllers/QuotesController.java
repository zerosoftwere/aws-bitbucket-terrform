package me.xerosoft.pagedemo.controllers;

import me.xerosoft.pagedemo.annotation.SwaggerDocumented;
import me.xerosoft.pagedemo.entites.QuoteEntity;
import me.xerosoft.pagedemo.services.QuotesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.persistence.EntityNotFoundException;
import java.util.Optional;

@RestController
@SwaggerDocumented
@RequestMapping("quotes")
public class QuotesController {

    @Autowired
    private QuotesService quotesService;

    @GetMapping
    public Page<QuoteEntity> getQuotes(
            @RequestParam(defaultValue = "") String author,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(defaultValue = "0") Integer page
    ) {
        return quotesService.list(author, page, size);
    }

    @GetMapping(value = "{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> getQuote(@PathVariable Long id) {
        try {
            return ResponseEntity.ok(quotesService.retrieve(id));
        } catch (EntityNotFoundException ex) {
            return new ResponseEntity<>(ex.getMessage(), HttpStatus.NOT_FOUND);
        }
    }
}
